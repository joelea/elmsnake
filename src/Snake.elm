module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Models exposing (..)
import ViewBoard exposing (..)

main : Program Never
main = Html.beginnerProgram { model = model, view = view, update = update }

type Msg = Noop | AnotherNoop

model : GameState
model =
    { boardSize = 10
    , food = Position 1 1
    , snake = [ Position 2 2, Position 2 3 ]
    }

update : Msg -> GameState -> GameState
update msg state = state
