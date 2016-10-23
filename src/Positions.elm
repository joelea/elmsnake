module Positions exposing (..)

type Direction = North | South | West | East

type alias Position =
    { x: Int
    , y: Int
    }

type TurnDirection = Left | Right

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

