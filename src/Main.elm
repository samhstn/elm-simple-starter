module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Process
import Task
import Time


main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { content = "Hello world" }, Cmd.none )


type Msg
    = NoOp
    | ShowAfterTimeout
    | ShowContent


type alias Model =
    { content : String
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


delay time msg =
    Process.sleep time
        |> Task.perform (\_ -> msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ShowAfterTimeout ->
            ( { model
                | content = "Showing \"Hello world\" after 2 seconds..."
              }
            , delay 2000 ShowContent
            )

        ShowContent ->
            ( { model | content = "Hello world" }, Cmd.none )


view : Model -> Html Msg
view model =
    if model.content == "Hello world" then
        div
            []
            [ div
                []
                [ text model.content
                ]
            , button
                [ onClick ShowAfterTimeout
                ]
                [ text "Click"
                ]
            ]

    else
        div
            []
            [ text model.content
            ]
