module Lib.Components exposing (..)

components : ()
components = ()

--import Lib.Optics exposing (..)

--import Browser
--import Html exposing (..)
--import Html.Attributes exposing (..)

---- | A reusable UI component.
--type alias Component state event =
--  { update : event -> state -> ( state, Cmd event )
--  , view   : state -> Html event
--  }

---- | Create a program from a component.
--runComponent :
--  { component : Component state event
--  , init : state
--  , title : state -> String
--  } -> Program () state event
--runComponent { component, init, title } =
--  Browser.document
--    { init = \() -> ( init, Cmd.none )
--    , subscriptions = \_ -> Sub.none
--    , update = component.update
--    , view = \state -> { title = title state, body = [ component.view state ] }
--    }

--batchUpdate : List (m -> s -> (s, Cmd m)) -> m -> s -> (s, Cmd m)
--batchUpdate updates event state =
--  let
--    ( newState, cmds ) =
--      List.foldr
--        (\u ( s, cs ) -> let ( s2, c2 ) = u event s in ( s2, c2::cs ))
--        ( state, [] )
--        updates
--  in
--  ( newState, Cmd.batch cmds )

--htmlRow : List ( Html event, Int ) -> Html event
--htmlRow htmls =
--  let
--    wTotal =
--      List.sum (List.map (\(_, w) -> w) htmls)

--    mkCell (html, w) =
--      div
--        [ style "float" "left"
--        , style "width" (String.fromFloat (toFloat w / toFloat wTotal))
--        ]
--        [ html ]

--  in
--  div
--    []
--    [ div
--        [ style "float" "left" ]
--        (List.map mkCell htmls)
--    , div
--        [ style "content" ""
--        , style "display" "table"
--        , style "clear" "both"
--        ]
--        []
--    ]

---- | Promote an html element into a stateless component.
--static : Html event -> Component state event
--static html =
--  { update = \m s -> ( s, Cmd.none )
--  , view = \s -> html
--  }

---- | Arrange components left-to-right into a single component.
--row : List ( Component state event, Int ) -> Component state event
--row components =
--  { update = batchUpdate ((List.map (\(cmp, _) -> cmp.update) components))
--  , view = \s -> htmlRow (List.map (\(cmp, w) -> (cmp.view s, w)) components)
--  }

---- | Arrange component top-to-bottom into a single component.
--col : List (Component state event) -> Component state event
--col components =
--  { update = batchUpdate (List.map .update components)
--  , view = \s -> div [] (List.map (\cmp -> cmp.view s) components)
--  }

---- | Use a lens to change the state type of a component.
--focus : Lens b a -> Component a event -> Component b event
--focus { get, set } { update, view } =
--  let
--    newUpdate event b =
--      let
--        ( aNew, cmd ) = update event (get b)
--      in
--      ( set aNew b, cmd )

--    newView b = view (get b)

--  in
--  Component newUpdate newView

---- | Use a prism to change the event type of a component.
--disperse : Prism b a -> Component state a -> Component state b
--disperse { cast, match } { update, view } =
--  let
--    newUpdate b state =
--      case match b of
--        Nothing ->
--          ( state, Cmd.none )

--        Just a ->
--          let
--            ( newState, aCmd ) = update a state
--          in
--          ( newState, Cmd.map cast aCmd )

--    newView state = Html.map cast (view state)

--  in
--  Component newUpdate newView
