module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, div, text)
import Html.Attributes exposing (href, style)
import Url exposing (Url)


main =
    Browser.application
        { init = init
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


type alias Model =
    { key : Nav.Key
    , page : Page
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( initialModel url key, Cmd.none )


initialModel : Url.Url -> Nav.Key -> Model
initialModel url key =
    { key = key
    , page = urlToPage url
    }


type Page
    = NotFound
    | Home
    | Search


urlToPage : Url.Url -> Page
urlToPage url =
    case url.path of
        "/" ->
            Home

        "/search" ->
            Search

        _ ->
            NotFound


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | page = urlToPage url }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "App - " ++ pageToString model.page
    , body = body model
    }


body : Model -> List (Html Msg)
body model =
    [ nav model
    , div
        [ style "text-align" "center"
        ]
        [ text <| pageToString model.page
        ]
    ]


nav : Model -> Html Msg
nav model =
    div
        [ style "display" "flex"
        , style "justify-content" "space-around"
        ]
        [ navItem model Home
        , navItem model Search
        ]


navItem : Model -> Page -> Html Msg
navItem model page =
    let
        textDecoration =
            if model.page == page then
                "underline"
            else
                "none"
    in
        a
            [ href <| pageToLink page
            , style "text-decoration" textDecoration
            ]
            [ text <| pageToString page
            ]


pageToLink : Page -> String
pageToLink page =
    case page of
        Home ->
            "/"

        _ ->
            pageToString page
                |> String.toLower
                |> String.append "/"


pageToString : Page -> String
pageToString page =
    case page of
        Home ->
            "Home"

        Search ->
            "Search"

        NotFound ->
            "404 - Not Found"
