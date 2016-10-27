module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Models exposing (..)
import ViewBoard exposing (..)
import Keyboard
import Positions exposing (..)
import KeyCodes

main : Program Never
main = Html.program { init = model ! [] , view = view, update = update, subscriptions = subscriptions }

respondToKey : Keyboard.KeyCode -> Msg
respondToKey keyCode =
    if keyCode == KeyCodes.up then MoveForward
    else Noop

subscriptions : GameState -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.presses respondToKey
        ]

type Msg = Noop | MoveForward

model : GameState
model =
    { boardSize = 10
    , food = Position 1 1
    , snake = [ Position 2 2, Position 2 3, Position 2 4, Position 3 4 ]
    , direction = South
    }

update : Msg -> GameState -> ( GameState, Cmd Msg )
update msg state =
    case msg of
        Noop -> ( state, Cmd.batch [])
        MoveForward -> ( moveForward state, Cmd.batch [] )

moveForward : GameState -> GameState
moveForward state =
    let
        snakeLength = List.length state.snake
        currentHead = Maybe.withDefault (Position 0 0) ( List.head state.snake )
        newHead = move South currentHead
        newSnake = List.take snakeLength ( newHead :: state.snake )
    in
    { state | snake = newSnake }


