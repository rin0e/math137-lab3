module Lib.Keyboard exposing
  ( KeyEvent(..)
  , Key(..)
  , keyPress
  , keyDown
  , keyUp
  , keyPresses
  , keyDowns
  , keyUps
  , showKey
  )

import Browser.Events
import Json.Decode

type KeyEvent
  = KeyPress Key
  | KeyDown Key
  | KeyUp Key

-- | Extract the `Key` from a `KeyPress` event.
keyPress : KeyEvent -> Maybe Key
keyPress event =
  case event of
    KeyPress key -> Just key
    _ -> Nothing

-- | Extract the `Key` from a `KeyDown` event.
keyDown : KeyEvent -> Maybe Key
keyDown event =
  case event of
    KeyDown key -> Just key
    _ -> Nothing

-- | Extract the `Key` from a `KeyUp` event.
keyUp : KeyEvent -> Maybe Key
keyUp event =
  case event of
    KeyUp key -> Just key
    _ -> Nothing

-- | Subscribe to key press events.
keyPresses : Sub KeyEvent
keyPresses = Sub.map KeyPress (Browser.Events.onKeyPress keyDecoder)

-- | Subscribe to key down events.
keyDowns : Sub KeyEvent
keyDowns = Sub.map KeyDown (Browser.Events.onKeyDown keyDecoder)

-- | Subscribe to key up events.
keyUps : Sub KeyEvent
keyUps = Sub.map KeyUp (Browser.Events.onKeyUp keyDecoder)

-- | Represents keys, not characters. In particular, does not distinguish
-- | between lower case and upper case.
type Key
  = K_Escape
  | K_F1
  | K_F2
  | K_F3
  | K_F4
  | K_F5
  | K_F6
  | K_F7
  | K_F8
  | K_F9
  | K_F10
  | K_F11
  | K_F12
  | K_Insert
  | K_Delete
  | K_Home
  | K_End
  | K_PageUp
  | K_PageDown
  | K_Up
  | K_Left
  | K_Down
  | K_Right
  | K_Tab
  | K_CapsLock
  | K_Shift
  | K_Control
  | K_Alt
  | K_Backspace
  | K_Enter
  | K_Space
  | K_Backtick
  | K_Hyphen
  | K_Equals
  | K_LeftBracket
  | K_RightBracket
  | K_Backslash
  | K_Semicolon
  | K_Apostrophe
  | K_Comma
  | K_Period
  | K_Slash
  | K_1
  | K_2
  | K_3
  | K_4
  | K_5
  | K_6
  | K_7
  | K_8
  | K_9
  | K_0
  | K_Q
  | K_W
  | K_E
  | K_R
  | K_T
  | K_Y
  | K_U
  | K_I
  | K_O
  | K_P
  | K_A
  | K_S
  | K_D
  | K_F
  | K_G
  | K_H
  | K_J
  | K_K
  | K_L
  | K_Z
  | K_X
  | K_C
  | K_V
  | K_B
  | K_N
  | K_M
  | K_Other String

-- | Render a `Key` value as a string
showKey : Key -> String
showKey key =
  case key of
    K_Escape -> "K_Escape"
    K_F1 -> "K_F1"
    K_F2 -> "K_F2"
    K_F3 -> "K_F3"
    K_F4 -> "K_F4"
    K_F5 -> "K_F5"
    K_F6 -> "K_F6"
    K_F7 -> "K_F7"
    K_F8 -> "K_F8"
    K_F9 -> "K_F9"
    K_F10 -> "K_F10"
    K_F11 -> "K_F11"
    K_F12 -> "K_F12"
    K_Insert -> "K_Insert"
    K_Delete -> "K_Delete"
    K_Home -> "K_Home"
    K_End -> "K_End"
    K_PageUp -> "K_PageUp"
    K_PageDown -> "K_PageDown"
    K_Up -> "K_Up"
    K_Left -> "K_Left"
    K_Down -> "K_Down"
    K_Right -> "K_Right"
    K_Tab -> "K_Tab"
    K_CapsLock -> "K_CapsLock"
    K_Shift -> "K_Shift"
    K_Control -> "K_Control"
    K_Alt -> "K_Alt"
    K_Backspace -> "K_Backspace"
    K_Enter -> "K_Enter"
    K_Space -> "K_Space"
    K_Backtick -> "K_Backtick"
    K_Hyphen -> "K_Hyphen"
    K_Equals -> "K_Equals"
    K_LeftBracket -> "K_LeftBracket"
    K_RightBracket -> "K_RightBracket"
    K_Backslash -> "K_Backslash"
    K_Semicolon -> "K_Semicolon"
    K_Apostrophe -> "K_Apostrophe"
    K_Comma -> "K_Comma"
    K_Period -> "K_Period"
    K_Slash -> "K_Slash"
    K_1 -> "K_1"
    K_2 -> "K_2"
    K_3 -> "K_3"
    K_4 -> "K_4"
    K_5 -> "K_5"
    K_6 -> "K_6"
    K_7 -> "K_7"
    K_8 -> "K_8"
    K_9 -> "K_9"
    K_0 -> "K_0"
    K_Q -> "K_Q"
    K_W -> "K_W"
    K_E -> "K_E"
    K_R -> "K_R"
    K_T -> "K_T"
    K_Y -> "K_Y"
    K_U -> "K_U"
    K_I -> "K_I"
    K_O -> "K_O"
    K_P -> "K_P"
    K_A -> "K_A"
    K_S -> "K_S"
    K_D -> "K_D"
    K_F -> "K_F"
    K_G -> "K_G"
    K_H -> "K_H"
    K_J -> "K_J"
    K_K -> "K_K"
    K_L -> "K_L"
    K_Z -> "K_Z"
    K_X -> "K_X"
    K_C -> "K_C"
    K_V -> "K_V"
    K_B -> "K_B"
    K_N -> "K_N"
    K_M -> "K_M"
    K_Other str -> "K_Other " ++ str

keyDecoder : Json.Decode.Decoder Key
keyDecoder =
  let
    decodeKey =
      Json.Decode.field "key" Json.Decode.string

    parseKey str =
      case str of
        "Escape" -> K_Escape
        "F1" -> K_F1
        "F2" -> K_F2
        "F3" -> K_F3
        "F4" -> K_F4
        "F5" -> K_F5
        "F6" -> K_F6
        "F7" -> K_F7
        "F8" -> K_F8
        "F9" -> K_F9
        "F10" -> K_F10
        "F11" -> K_F11
        "F12" -> K_F12
        "Insert" -> K_Insert
        "Delete" -> K_Delete
        "Home" -> K_Home
        "End" -> K_End
        "PageUp" -> K_PageUp
        "PageDown" -> K_PageDown
        "ArrowUp" -> K_Up
        "ArrowLeft" -> K_Left
        "ArrowDown" -> K_Down
        "ArrowRight" -> K_Right
        "Tab" -> K_Tab
        "CapsLock" -> K_CapsLock
        "Shift" -> K_Shift
        "Control" -> K_Control
        "Alt" -> K_Alt
        "Backspace" -> K_Backspace
        "Enter" -> K_Enter
        " " -> K_Space
        "`" -> K_Backtick
        "~" -> K_Backtick
        "-" -> K_Hyphen
        "_" -> K_Hyphen
        "=" -> K_Equals
        "+" -> K_Equals
        "[" -> K_LeftBracket
        "{" -> K_LeftBracket
        "]" -> K_RightBracket
        "}" -> K_RightBracket
        "\\" -> K_Backslash
        "|" -> K_Backslash
        ";" -> K_Semicolon
        ":" -> K_Semicolon
        "'" -> K_Apostrophe
        "\"" -> K_Apostrophe
        "," -> K_Comma
        "<" -> K_Comma
        "." -> K_Period
        ">" -> K_Period
        "/" -> K_Slash
        "?" -> K_Slash
        "1" -> K_1
        "!" -> K_1
        "2" -> K_2
        "@" -> K_2
        "3" -> K_3
        "#" -> K_3
        "4" -> K_4
        "$" -> K_4
        "5" -> K_5
        "%" -> K_5
        "6" -> K_6
        "^" -> K_6
        "7" -> K_7
        "&" -> K_7
        "8" -> K_8
        "*" -> K_8
        "9" -> K_9
        "(" -> K_9
        "0" -> K_0
        ")" -> K_0
        "q" -> K_Q
        "Q" -> K_Q
        "w" -> K_W
        "W" -> K_W
        "e" -> K_E
        "E" -> K_E
        "r" -> K_R
        "R" -> K_R
        "t" -> K_T
        "T" -> K_T
        "y" -> K_Y
        "Y" -> K_Y
        "u" -> K_U
        "U" -> K_U
        "i" -> K_I
        "I" -> K_I
        "o" -> K_O
        "O" -> K_O
        "p" -> K_P
        "P" -> K_P
        "a" -> K_A
        "A" -> K_A
        "s" -> K_S
        "S" -> K_S
        "d" -> K_D
        "D" -> K_D
        "f" -> K_F
        "F" -> K_F
        "g" -> K_G
        "G" -> K_G
        "h" -> K_H
        "H" -> K_H
        "j" -> K_J
        "J" -> K_J
        "k" -> K_K
        "K" -> K_K
        "l" -> K_L
        "L" -> K_L
        "z" -> K_Z
        "Z" -> K_Z
        "x" -> K_X
        "X" -> K_X
        "c" -> K_C
        "C" -> K_C
        "v" -> K_V
        "V" -> K_V
        "b" -> K_B
        "B" -> K_B
        "n" -> K_N
        "N" -> K_N
        "m" -> K_M
        "M" -> K_M
        _ -> K_Other str

  in
  Json.Decode.map parseKey decodeKey
