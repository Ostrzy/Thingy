module Entity where

type alias Entities = List Entity

type alias Entity =
  { position: (Int, Int)
  , display: String
  }
