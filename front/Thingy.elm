module Thingy where

import Graphics.Element exposing (show)
import Task exposing (Task, andThen)
import String
import Time
import SocketIO


--One day, there will be a server writing to me...
socket : Task x SocketIO.Socket
socket = SocketIO.io "http://localhost:8001" SocketIO.defaultOptions

received : Signal.Mailbox String
received = Signal.mailbox "No data"

-- set up the receiving of data
port responses : Task x ()
port responses = socket `andThen` SocketIO.on "" received.address

main = Signal.map show received.signal
