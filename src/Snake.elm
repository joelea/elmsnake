module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Models exposing (..)
import ViewBoard exposing (..)
import Keyboard

main : Program Never
main = Html.program { init = ( model, Cmd.none ), view = view, update = update, subscriptions = subscriptions }

filterDowns : Keyboard.KeyCode -> Msg
filterDowns keyCode = if keyCode == 38 then Tick else Noop

filterLefts : Keyboard.KeyCode -> Msg
filterLefts keyCode = if keyCode == 37 then Turn Right else Noop

filterRights : Keyboard.KeyCode -> Msg
filterRights keyCode = if keyCode == 39 then Turn Left else Noop

subscriptions : GameState -> Sub Msg
subscriptions model = Sub.batch
    [ Keyboard.presses filterDowns
    , Keyboard.presses filterLefts
    , Keyboard.presses filterRights
    ]

type TurnDirection = Left | Right

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
        Tick -> moveSnakeForward state ! []
        Turn direction -> turnSnake direction state ! []
        Noop -> state ! []

turnSnake : TurnDirection -> GameState -> GameState
turnSnake direction state = { state | direction = turn direction state.direction }

turn : TurnDirection -> Direction -> Direction
turn turnDirection direction =
    case turnDirection of
        Left -> turnLeft direction
        Right -> turnRight direction

turnRight direction = turnLeft <| turnLeft <| turnLeft direction

turnLeft direction =
    case direction of
        North -> West
        West -> South
        South -> East
        East -> North

move direction position =
    case direction of
        North -> { position | y = position.y + 1 }
        South -> { position | y = position.y - 1 }
        West -> { position | x = position.x - 1 }
        East -> { position | x = position.x + 1 }

moveSnakeForward : GameState -> GameState
moveSnakeForward state =
    let
        snakeLength = List.length state.snake
        oldHead = Maybe.withDefault (Position 0 0) <| List.head state.snake
        newHead = move state.direction oldHead
        newSnake = List.take snakeLength <| newHead :: state.snake
    in
    { state | snake = newSnake }
