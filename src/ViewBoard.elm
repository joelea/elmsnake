module ViewBoard exposing (view)

import Models exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Positions exposing (..)

type alias Board = List ( List Square )

type Square = Empty | Snake | Food

view : GameState -> Html a
view state = viewBoard <| createBoard state

squareColor : Square -> String
squareColor square =
    case square of
        Empty -> "lightgrey"
        Snake -> "blue"
        Food -> "red"

viewBoard board =
    let
        viewSquare square = div [ style [ ("backgroundColor", squareColor square), ("width", "20px"), ("height", "20px"), ("margin", "2px") ] ] []
        viewRow row = div [ style flexRow ] <| List.map viewSquare row

        flexRow = [ ("display", "flex") ]
        flexColumn = [ ("display", "flex"), ("flex-direction", "column") ]
    in
    div [ style flexColumn ] <| List.map viewRow board


emptyBoard { boardSize } = List.repeat boardSize <| List.repeat boardSize Empty

squareGenerator : GameState -> Int -> Int -> a -> Square
squareGenerator state rowIndex columnIndex _ =
    let
        position = Position columnIndex rowIndex
        containsSnake = List.member position state.snake
        containsFood = state.food == position
    in
    if containsSnake then Snake
    else if containsFood then Food
    else Empty


createBoard : GameState -> Board
createBoard state =
    gridMap ( squareGenerator state ) ( emptyBoard state )

gridMap : ( Int -> Int -> a -> b ) -> List ( List a ) -> List ( List b )
gridMap f grid =
    let
        rowFunction rowIndex row = List.indexedMap (f rowIndex) row
    in
    List.indexedMap rowFunction grid
