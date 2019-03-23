module Lib.Optics exposing (..)

{-| Helper types and functions for getting, setting, updating, and
generally reaching nested data.

An example:

    type alias GameState =
      { players : List Unit
      , enemies : List Unit
      , playersTurn : Bool
      }

    players : Traversal GameState Unit
    players =
      let
        listPlayers gs = gs.players
        overPlayers f gs = { gs | players = List.map f gs.players }
      in
      traversal listPlayers overPlayers

    type alias Unit =
      { health : Int
      , position : (Int, Int)
      , class : Class
      }

    class : Lens Unit Class
    class =
      let
        getClass u = u.class
        setClass c u = { u | class = c }
      in
      lens getClass setClass

    type Class
      = Archer { agility : Int , arrows : Int }
      | Sorcerer { intelligence : Int , spells : List String }
      | Swordsman { strength : Int }

    primaryStat : Lens Class Int
    primaryStat =
      let
        getPrimaryStat c =
          case c of
            Archer { agility } -> agility
            Sorcerer { intelligence } -> intelligence
            Swordsman { strength } -> strength

        setPrimaryStat n c =
          case c of
            Archer a -> Archer { a | agility = n }
            Sorcerer s -> Sorcerer { s | intelligence = n }
            Swordsman s -> Swordsman { s | strength = n }
      in
      lens getPrimaryStat setPrimaryStat

    buffPlayers : GameState -> GameState
    buffPlayers gameState =
      (players.over |> overs class.over |> overs primaryStat.over)
      (\n -> n + 10)
      gameState

The expression

    players.over |> overs class.over |> overs primaryStat.over)

is a composition of the `players` `Traversal`, the `class` `Lens`, and
the `primaryStat` `Lens`. Tt allows us to apply a function to each
player's primary stat.

We pay the upfront cost of defining lenses and traversals for our data
structures, and in return we have the benefit of easily being able to
reach in and access and manipulate nested data. The more often we need
to write functions like `buffPlayers`, the more benefit we gain from our
upfront investment.

The upfront cost of defining lenses, prisms, and traversals is not
always worth it in every program. But for some programs, optics can
make the code much clearer and shorter.

# Lenses
@docs Lens, lens

# Prisms
@docs Prism, prism

# Traversals
@docs Traversal, traversal

# Composing
@docs lists, overs, views, casts

-}


import Lib.Maybe as Maybe


{-| A dictionary of functions for getting, setting, and updating a
particular field of a data structure.
-}
type alias Lens s a =
  { list : s -> List a
  , over : (a -> a) -> s -> s
  , view : s -> a
  }


{-| Create a lens by providing a getting function and a setting
function.
-}
lens : (s -> a) -> (a -> s -> s) -> Lens s a
lens get set =
  { list = List.singleton << get
  , over = \f y -> set (get y) y
  , view = get
  }


{-| A dictionary of functions for case-matching and up-casting a
particular variant of a union type.
-}
type alias Prism s a =
  { list : s -> List a
  , over : (a -> a) -> s -> s
  , cast : a -> s
  }


{-| Create a prism by providing a casting function and a matching
function.
-}
prism : (a -> s) -> (s -> Maybe a) -> Prism s a
prism cast match  =
  { list = \y -> match y |> Maybe.reduce [] List.singleton
  , over = \f y -> match y |> Maybe.reduce y (f >> cast)
  , cast = cast
  }


{-| A dictionary of functions for listing and updating elements of a
collection-like type.
-}
type alias Traversal s a =
  { list : s -> List a
  , over : (a -> a) -> s -> s
  }


{-| Create a traversal by providing a listing function and an updating
function.
-}
traversal : (s -> List a) -> ((a -> a) -> s -> s) -> Traversal s a
traversal list over =
  { list = list
  , over = over
  }


{-| Compose two listing functions, allowing you to list nested data.
-}
lists : (y -> List x) -> (z -> List y) -> (z -> List x)
lists inner outer = List.concatMap inner << outer


{-| Compose two updating functions, allowing you to update nested data.
-}
overs : ((x -> x) -> y -> y) -> ((y -> y) -> z -> z) -> ((x -> x) -> z -> z)
overs inner outer = outer << inner


{-| Compose two getting functions, allowing you to get nested data.
-}
views : (y -> x) -> (z -> y) -> (z -> x)
views inner outer = inner << outer


{-| Compose two upcasting functions, allowing you to upcast through
several layers at once.
-}
casts : (x -> y) -> (y -> z) -> (x -> z)
casts inner outer = outer << inner
