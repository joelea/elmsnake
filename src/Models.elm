module Models exposing (..)

type alias Board = List ( List Square )

type Square = Empty | Snake | Food

type alias GameState =
    { boardSize: Int
    , food: Position
    , snake: List Position
    , direction: Direction
    }

type Direction = North | South | West | East

type alias Position =
    { x: Int
    , y: Int
    }

