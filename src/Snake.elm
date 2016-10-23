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
    if keyCode == KeyCodes.up then Noop
    else Noop

subscriptions : GameState -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.presses respondToKey
        ]

type Msg = Noop

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
        Noop -> state ! []

