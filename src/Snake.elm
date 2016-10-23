module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Models exposing (..)
import ViewBoard exposing (..)
import Keyboard

main : Program Never
main = Html.program { init = ( model, Cmd.none ), view = view, update = update, subscriptions = subscriptions }

up = 38

filterDowns : Keyboard.KeyCode -> Msg
filterDowns keyCode = if keyCode == up then Tick else Noop

subscriptions : GameState -> Sub Msg
subscriptions model = Sub.batch
    [ Keyboard.presses filterDowns
    ]

type Msg = Noop | Tick

model : GameState
model =
    { boardSize = 10
    , food = Position 1 1
    , snake = [ Position 2 2, Position 2 3 ]
    }

update : Msg -> GameState -> ( GameState, Cmd Msg )
update msg state =
    case msg of
        Tick -> moveSnakeForward state ! []
        Noop -> state ! []

moveUp position = { position | y = position.y + 1 }

moveSnakeForward : GameState -> GameState
moveSnakeForward state =
    let
        snakeLength = List.length state.snake
        oldHead = Maybe.withDefault (Position 0 0) <| List.head state.snake
        newHead = moveUp oldHead
        newSnake = List.take snakeLength <| newHead :: state.snake
    in
    { state | snake = newSnake }
