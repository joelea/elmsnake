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

filterUps : Keyboard.KeyCode -> Msg
filterUps keyCode = if keyCode == KeyCodes.up then Tick else Noop

filterLefts : Keyboard.KeyCode -> Msg
filterLefts keyCode = if keyCode == KeyCodes.left then Turn Right else Noop

filterRights : Keyboard.KeyCode -> Msg
filterRights keyCode = if keyCode == KeyCodes.right then Turn Left else Noop

subscriptions : GameState -> Sub Msg
subscriptions model = Sub.batch
    [ Keyboard.presses filterUps
    , Keyboard.presses filterLefts
    , Keyboard.presses filterRights
    ]

type Msg = Noop | Tick | Turn TurnDirection

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
        Tick -> tickSnake state ! []
        Turn direction -> turnSnake direction state ! []
        Noop -> state ! []

turnSnake : TurnDirection -> GameState -> GameState
turnSnake direction state = { state | direction = turn direction state.direction }

tickSnake : GameState -> GameState
tickSnake state =
    let
        snakeLength = List.length state.snake
        oldHead = Maybe.withDefault (Position 0 0) <| List.head state.snake
        newHead = move state.direction oldHead
        newSnake = List.take snakeLength <| newHead :: state.snake
    in
    { state | snake = newSnake }
