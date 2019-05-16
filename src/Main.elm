import Lib.Color as Color
import Lib.Graphics as Graphics
import Lib.Game as Game
import Lib.Keyboard as Keyboard
import Lib.Memoize as Memoize
import Lib.List as List

import Debug exposing (todo)

import Life exposing (Board, Cell, CellStatus(..), nextBoard)


-- To define a program, we need
--   1. A type for the possible states         type State
--   2. A type for the possible events         type Event
--   3. A transition function                  update : event -> state -> state
--   4. An initial state                       init : state
--   5. A view function                        view : state -> Canvas event


-- A type for your game state. As your game gets more features, you will
-- probably add more fields to this type.
type alias State = { board : Board, paused : Bool }


-- A type for your game events. As your game gets more features, you will
-- probably add more variants to this type.
type Event = NoOp | CellClick Cell


main : Game.Game State Event
main =
  Game.game
    { init = initialState
    , update = updateGame
    , view = drawGame
    }


-- This is the board our game will start with.
initialState : State
initialState =
  let
    startingBoard : Board
    startingBoard cell = 
      case (cell.x, cell.y) of
        (1, 0) -> Alive
        (2, 1) -> Alive
        (0, 2) -> Alive
        (1, 2) -> Alive
        (2, 2) -> Alive
        (_, _) -> Dead
  in
  { board = startingBoard, paused = True }

memoStrat : Memoize.MemoizeStrategy (Int, Int) Cell CellStatus
memoStrat =
  let
      cellToPair cell = (cell.x, cell.y)
      pairToCell (x0, y0) = { x = x0, y = y0 }
      allPairs = List.map cellToPair allCells
      defaultStatus = Dead
    in
    { toKey = cellToPair, fromKey = pairToCell, domain = allPairs, default = defaultStatus }


-- This function uses the incoming event and the current game state to
-- decide what the next game state should be.
updateGame : Game.GameEvent Event -> State -> State
updateGame event currentState =
  case event of
    -- What to do when we get a `ClockTick`
    Game.ClockTick timestamp ->
      if currentState.paused
        then currentState
        else
          let
            updatedBoard = nextBoard currentState.board
            memoizedBoard = Memoize.memoize memoStrat updatedBoard  
          in
          { board = memoizedBoard, paused = currentState.paused }

    -- What to do when the player presses or releases a key
    Game.Keyboard keyEvent ->
      case keyEvent of
        Keyboard.KeyEventDown Keyboard.KeySpace ->
          let
              currentPaused = currentState.paused
              newPaused = case currentPaused of
                True -> False
                False -> True
          in
          {board = currentState.board , paused = newPaused}
        _ -> currentState

    -- What to do when we get a `NoOp`
    Game.Custom NoOp->
      currentState

    Game.Custom (CellClick cell) ->
      let
          newBoard = flipCell cell currentState.board
      in
      { board = newBoard, paused = currentState.paused }
      
flipCell : Cell -> Board -> Board
flipCell clickedCell oldBoard =
  let
    newBoard : Cell -> CellStatus
    newBoard cell =
      if cell == clickedCell
        then 
          case oldBoard cell of
           Dead -> Alive
           Alive -> Dead
        else oldBoard cell
      -- todo "if cell and clickedCell are the same, do the opposite of what the old board says"
      -- todo "if cell and clickedCell are different, just plug c into the old board"
  in
  newBoard

-- Pick a size for the game board.
-- Hint: Use this when you go to write `drawCell` and `drawGame`
boardSize : Int
boardSize = 30


-- The list of all cells based on your `boardSize`.
allCells : List Cell
allCells =
  let
    range = List.range 0 boardSize
    toCell (x_coord, y_coord) = { x = x_coord, y = y_coord }
  in
  List.map toCell (List.cross range range)


-- This function will use the game state to decide what to draw on the screen.
drawGame : State -> Graphics.Canvas Event
drawGame state =
  let
    drawCell : Cell -> Graphics.Svg Event
    drawCell cell =
      let
        cellStatus : CellStatus
        cellStatus = state.board(cell)

        cellColor : Color.Color
        cellColor = 
          case cellStatus of
            Alive -> Color.lime
            Dead -> Color.navy
      in
      Graphics.drawRect 
        { x0 = toFloat cell.x
        , y0 = toFloat cell.y
        , width = (1)
        , height = (1)
        , fill = cellColor
        , onClick = Just (CellClick cell)
        }

    cells : List (Graphics.Svg Event)
    cells = List.map drawCell allCells

  in
  Graphics.canvas
    { title = "Erins Game of Life"
    , widthPx = 300
    , heightPx = 300
    , xMax = toFloat boardSize
    , yMax = toFloat boardSize
    , children = cells
    }
