module Life exposing (..)

import Debug exposing (todo)

type alias Cell = { x : Int, y : Int }

type CellStatus = Dead | Alive

type alias Board = Cell -> CellStatus

-- calculates the next status of a cell, given
-- the number of living neighbors and the cell's
-- current status.
nextStatus : Int -> CellStatus -> CellStatus
nextStatus numberOfLivingNeighbors currentStatus =
  case (currentStatus, numberOfLivingNeighbors) of
    (Alive, 2) -> Alive
    (Alive, 3) -> Alive
    (Alive, _) -> Dead
    (Dead, 3) -> Alive
    (Dead, _) -> Dead

-- calculates the number of living neighbors of a cell,
-- given a board and a cell.
livingNeighbors : Board -> Cell -> Int
livingNeighbors currentBoard { x, y } =
  let
    neighbors : List Cell
    neighbors =
      [ { x = x - 1, y = y - 1 }
      , { x = x    , y = y - 1 }
      , { x = x + 1, y = y - 1 }
      , { x = x - 1, y = y     }
      , { x = x + 1, y = y     }
      , { x = x - 1, y = y + 1 }
      , { x = x    , y = y + 1 }
      , { x = x + 1, y = y + 1 }
      ]

    statuses : List CellStatus
    statuses = List.map currentBoard neighbors

    numericStatus : CellStatus -> Int
    numericStatus status =
      case status of
        Alive -> 1
        Dead -> 0

    numericStatuses : List Int
    numericStatuses = List.map (numericStatus) (statuses)

    listSum : Int
    listSum = List.sum numericStatuses
  in
  listSum

-- calculates the next board given the current board.
nextBoard : Board -> Board
nextBoard currentBoard =
 let
    theNextBoard : Cell -> CellStatus
    theNextBoard cell =
      nextStatus (livingNeighbors currentBoard cell) (currentBoard cell)
  in
  theNextBoard
