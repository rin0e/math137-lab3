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
  todo "Copy your Lab 2 Code Here!"

-- calculates the number of living neighbors of a cell,
-- given a board and a cell.
livingNeighbors : Board -> Cell -> Int
livingNeighbors currentBoard { x, y } =
  todo "Copy your Lab 2 Code Here!"

-- calculates the next board given the current board.
nextBoard : Board -> Board
nextBoard currentBoard =
  todo "Copy your Lab 2 Code Here!"
