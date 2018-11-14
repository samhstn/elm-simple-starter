port module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Json.Encode as Encode


main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


port cache : Encode.Value -> Cmd msg


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( flags, Cmd.none )


type alias Model =
    Int


type alias Flags =
    Int


type Msg
    = NoOp
    | Increment
    | Decrement
    | Reset


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Increment ->
            ( model + 1, cache (Encode.int (model + 1)) )

        Decrement ->
            ( model - 1, cache (Encode.int (model - 1)) )

        Reset ->
            ( 0, cache (Encode.int 0) )


view : Model -> Html Msg
view model =
    div
        []
        [ div
            []
            [ text (String.fromInt model)
            ]
        , div
            []
            [ button
                [ onClick Increment
                ]
                [ text "+"
                ]
            , button
                [ onClick Decrement
                ]
                [ text "-"
                ]
            , button
                [ onClick Reset
                ]
                [ text "reset"
                ]
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
