module MainForm exposing (..)

import Html exposing (..)
import Html.App exposing (beginnerProgram)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Zipcode


type alias Model =
    { zipcode : Maybe String
    , zipcodeEntry : String
    }


type Msg
    = ZipCodeChanged String



-- update


update msg model =
    case Debug.log "update" msg of
        ZipCodeChanged newEntry ->
            { model | zipcodeEntry = newEntry }



-- model


initialModel : Model
initialModel =
    { zipcode = Nothing
    , zipcodeEntry = ""
    }



-- view


view : Model -> Html Msg
view model =
    Html.form [ class "pure-form pure-form-aligned" ]
        [ fieldset []
            [ div [ class "pure-control-group" ]
                [ label [ for "zipcode" ] [ text "Zip Code" ]
                , input [ id "zipcode", type' "text", placeholder "Zip Code", classList [ ( "input-invalid", not (Zipcode.isValid model.zipcodeEntry) ) ], onInput ZipCodeChanged ] []
                ]
            ]
        ]


main : Program Never
main =
    Html.App.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
