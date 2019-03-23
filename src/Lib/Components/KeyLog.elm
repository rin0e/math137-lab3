module Lib.Components.KeyLog exposing (KeyLog, keyLog)

type alias KeyLog = ()

keyLog : ()
keyLog = ()

--import Lib.Components exposing (..)
--import Lib.Keyboard exposing (..)
--import Lib.Optics exposing (..)

--import Browser
--import Html exposing (..)
--import Html.Attributes exposing (..)

--type alias KeyLog =
--  { press : List Key
--  , down  : List Key
--  , up    : List Key
--  }

--press : List Key -> KeyLog -> KeyLog
--press keys log = { log | press = keys }

--down : List Key -> KeyLog -> KeyLog
--down keys log = { log | down = keys }

--up : List Key -> KeyLog -> KeyLog
--up keys log = { log | up = keys }

--ledger : String -> (a -> String) -> Component (List a) a
--ledger title show =
--  { update = \x xs -> ( x :: xs, Cmd.none )
--  , view = \xs ->
--      div
--        []
--        [ h2
--            [ style "text-align" "center" ]
--            [ text title ]
--        , h3
--            [ style "text-align" "center" ]
--            (xs |> List.take 1 |> List.map (show >> text))
--        , ul
--            []
--            (xs
--              |> List.drop 1
--              |> List.map (show >> text >> (\x -> [x]) >> li []))
--        ]
--  }

--keyLog : Component KeyLog KeyEvent
--keyLog =
--  let
--    presses =
--      ledger "Press" showKey
--        |> focus (Lens .press press)
--        |> disperse (Prism KeyPress keyPress)

--    downs =
--      ledger "Down" showKey
--        |> focus (Lens .down down)
--        |> disperse (Prism KeyDown keyDown)

--    ups =
--      ledger "Up" showKey
--        |> focus (Lens .up up)
--        |> disperse (Prism KeyUp keyUp)

--  in
--  row [ (presses, 1), (downs, 1), (ups, 1) ]

--main : Program () KeyLog KeyEvent
--main =
--  runComponent
--    { component = keyLog
--    , init = KeyLog [] [] []
--    , subscriptions = Sub.batch [ keyPresses, keyDowns, keyUps ]
--    , title = \_ -> "KeyLog"
--    }
