module Entity where

import Graphics.Element exposing (Element)
import Graphics.Collage exposing (Form, square, filled, move, collage)
import Color exposing (Color, rgb)

type alias Entities = List Entity

type alias Entity =
  { position: (Int, Int)
  , display: String
  }

view : List Entity -> Element
view es = collage 1500 1500 (List.map form es)

form : Entity -> Form
form {position, display} = let
    (x, y) = position
  in
    square 50.0 |> filled (color display) |> move (toFloat(x) * 50.0, toFloat(y) * 50.0)

color : String -> Color
color id = case id of
  "dragon"      -> rgb 0 100 0
  "meat_chunk"  -> rgb 200 0 0
  _             -> rgb 0 0 0
