module Decode exposing (decodeResponse)

import Json.Decode as Decode exposing (Decoder, (:=))

import Entity exposing (Entity, Entities)


decodeResponse : String -> Result String Entities
decodeResponse = Decode.decodeString entities

entities : Decoder Entities
entities = Decode.list entity

entity : Decoder Entity
entity =
  Decode.object2 Entity
    ("position" := position)
    ("display" := Decode.string)

position : Decoder (Int, Int)
position =
  Decode.object2 (,)
    ("x" := Decode.int)
    ("y" := Decode.int)
