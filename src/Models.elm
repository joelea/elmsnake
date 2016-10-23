module Models exposing (..)

import Positions exposing (..)

type alias GameState =
    { boardSize: Int
    , food: Position
    , snake: List Position
    , direction: Direction
    }
