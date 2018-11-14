module Main exposing (main)

import Browser
import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)


main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { count = 0
    }


type alias Model =
    { count : Int
    }


type Msg
    = NoOp
    | Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )


view : Model -> Html Msg
view model =
    div
        []
        [ div
            []
            [ text "Count is sent to and rendered from the server"
            ]
        , div
            []
            [ text <| String.fromInt model.count
            ]
        , div
            []
            [ button
                [ onClick Increment ]
                [ text "+"
                ]
            , button
                [ onClick Decrement ]
                [ text "-"
                ]
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
