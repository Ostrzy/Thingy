module Thingy where

import Graphics.Element exposing (show)
import Task exposing (Task, andThen)
import String
import Time
import WebSocket


--One day, there will be a server writing to me...
socket : Task x WebSocket.WebSocket
socket = WebSocket.create "ws://localhost:8001" received.address

received : Signal.Mailbox WebSocket.SocketEvent
received = Signal.mailbox <| WebSocket.Msg"No data"

-- set up the receiving of data
port responses : Task x WebSocket.WebSocket
port responses = socket

main = Signal.map show received.signal
