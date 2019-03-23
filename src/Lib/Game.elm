module Lib.Game exposing (Time, GameEvent(..), Game, game)

import Browser
import Html
import Time

import Lib.Graphics exposing (Canvas)

-- A computer representation of time. It is the same all over Earth,
-- so if we have a phone call or meeting at a certain POSIX time, there
-- is no ambiguity [quoted from Elm documentation].
type alias Time = Time.Posix

-- Events that your game must respond to.
type GameEvent e
  = ClockTick Time
  | Custom e

-- A simple game, with state type 's' and custom event type 'e'.
type alias Game s e = Program () s (GameEvent e)

-- Create a game.
game :
  { init : s
  , update : GameEvent e -> s -> s
  , view : s -> Canvas e
  } ->
  Game s e
game props =
  Browser.document
    { init = \_ -> (props.init, Cmd.none)
    , update = \e s -> (props.update e s, Cmd.none)
    , subscriptions = \_ ->
        let
          clock = Time.every 100 ClockTick
        in
        Sub.batch [clock]
    , view = \s ->
        let
          { title, body } = props.view s
          newBody = List.map (Html.map Custom) body
        in
        { title = title, body = newBody }
    }
