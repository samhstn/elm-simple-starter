module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, getCount )


getCount : Cmd Msg
getCount =
    Http.get
        { url = "/api/count"
        , expect = Http.expectJson NewCount countDecoder
        }


increment : Cmd Msg
increment =
    Http.post
        { url = "/api/count"
        , body = Http.jsonBody (typeEncoder "increment")
        , expect = Http.expectJson NewCount countDecoder
        }


decrement : Cmd Msg
decrement =
    Http.post
        { url = "/api/count"
        , body = Http.jsonBody (typeEncoder "increment")
        , expect = Http.expectJson NewCount countDecoder
        }


typeEncoder : String -> Encode.Value
typeEncoder t =
    Encode.object
        [ ( "type", Encode.string t )
        ]


countDecoder : Decoder Model
countDecoder =
    Decode.map Model
        (Decode.field "count" Decode.int)


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
    | NewCount (Result Http.Error Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Increment ->
            ( model, increment )

        Decrement ->
            ( model, decrement )

        NewCount (Ok newModel) ->
            ( newModel, Cmd.none )

        NewCount (Err err) ->
            -- Commented as was getting the compile error:
            -- `But the --optimize flag only works if all `Debug` functions are removed!`
            -- TODO: Handle this error case properly
            -- let
            --     _ =
            --         Debug.log "ERR" err
            -- in
            ( model, Cmd.none )


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
