module Models exposing (..)

type alias Board = List ( List Square )

type Square = Empty | Snake | Food

type alias GameState =
    { boardSize: Int
    , food: Position
    , snake: List Position
    }

type alias Position =
    { x: Int
    , y: Int
    }

