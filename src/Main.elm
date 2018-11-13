module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


init : Model
init =
    0


type alias Model =
    Int


type Msg
    = NoOp
    | Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        Increment ->
            model + 1

        Decrement ->
            model - 1


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
            ]
        ]
