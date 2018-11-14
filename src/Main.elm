port module Main exposing (main)

import Browser
import Html exposing (Html, button, div, input, text)
import Html.Events exposing (onClick, onInput)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


type alias Model =
    { message : String
    , inputText : String
    , err : Maybe String
    }


type Msg
    = NoOp
    | UpdateInput String
    | SendMessage
    | ReceiveMessage Encode.Value


initialModel =
    { message = ""
    , inputText = ""
    , err = Nothing
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    receiveMessage ReceiveMessage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UpdateInput t ->
            ( { model | inputText = t }, Cmd.none )

        SendMessage ->
            ( model, sendMessage (Encode.string model.inputText) )

        ReceiveMessage val ->
            case Decode.decodeValue Decode.string val of
                Ok message ->
                    ( { model | message = message }, Cmd.none )

                Err err ->
                    ( { model | err = Just "failed" }, Cmd.none )


port sendMessage : Encode.Value -> Cmd msg


port receiveMessage : (Encode.Value -> msg) -> Sub msg


view : Model -> Html Msg
view model =
    div
        []
        [ div
            []
            [ text model.message
            ]
        , div
            []
            [ input
                [ onInput UpdateInput
                ]
                []
            ]
        , div
            []
            [ button
                [ onClick SendMessage
                ]
                [ text "Send"
                ]
            ]
        ]
