module Thingy where

import Graphics.Element exposing (show)
import Task exposing (Task)
import WebSocket exposing (WebSocket, SocketEvent)

import Entity exposing (Entity, Entities)
import Decode

eventToResult : SocketEvent -> Result String String
eventToResult event = case event of
  WebSocket.Msg string -> Ok string
  WebSocket.Close -> Err "Closed"

-- set up the receiving of data
port responses : Task x WebSocket
port responses = WebSocket.create "ws://localhost:8001" received.address

received : Signal.Mailbox SocketEvent
received = Signal.mailbox <| WebSocket.Msg "No data"

andThen2 : (a -> Result x b) -> (b -> Result x c) -> (a -> Result x c)
andThen2 f g = f >> (\r -> r `Result.andThen` g)

entities : Signal (Result String Entities)
entities = Signal.map (eventToResult `andThen2` Decode.decodeResponse) received.signal

main = Signal.map show entities
