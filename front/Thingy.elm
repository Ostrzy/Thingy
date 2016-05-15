module Thingy exposing (main)

import Element exposing (Element)
import WebSocket

import Entity exposing (Entity, Entities, view)
import Decode exposing (decodeResponse)

import Html exposing (Html)
import Html.App as Html

type alias Model = Entities

type Msg
  = RefreshData Entities

main = Html.program { init = init, update = update, subscriptions = subscriptions, view = view }

init : (Model, Cmd Msg)
init = ([], Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update message _ =
  case message of
    RefreshData entities ->
      (entities, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions _ =
  WebSocket.listen "ws://localhost:8001" <| RefreshData << extractEntities

view : Model -> Html Msg
view model = Element.toHtml <| Entity.view model


extractEntities : String -> Entities
extractEntities json =
  case decodeResponse json of
    Ok entities ->
      entities

    Err _ ->
      []
