module MainForm exposing (..)

import Html exposing (..)
import Html.App exposing (beginnerProgram)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onSubmit)
import Zipcode


type alias Model =
    { zipcode : Maybe String
    , zipcodeEntry : String
    }


type Msg
    = ZipcodeChanged String
    | SubmitZipcode



-- update


update msg model =
    case Debug.log "update" msg of
        ZipcodeChanged newEntry ->
            { model | zipcodeEntry = newEntry }

        SubmitZipcode ->
            if Zipcode.isValid model.zipcodeEntry then
                { model | zipcode = Just model.zipcodeEntry }
            else
                model



-- model


initialModel : Model
initialModel =
    { zipcode = Nothing
    , zipcodeEntry = ""
    }



-- view


view : Model -> Html Msg
view model =
    let
        zipcodeIsValid =
            Zipcode.isValid model.zipcodeEntry
    in
        Html.form [ class "pure-form pure-form-aligned", onSubmit SubmitZipcode ]
            [ fieldset []
                [ div [ class "pure-control-group" ]
                    [ label [ for "zipcode" ] [ text "Zip Code" ]
                    , input
                        [ id "zipcode"
                        , type' "text"
                        , placeholder "Zip Code"
                        , classList
                            [ ( "input-invalid", not zipcodeIsValid )
                            , ( "input-valid", zipcodeIsValid )
                            ]
                        , onInput ZipcodeChanged
                        ]
                        []
                    ]
                , div [ class "pure-controls" ]
                    [ button
                        [ type' "submit"
                        , classList
                            [ ( "pure-button-disabled", not zipcodeIsValid )
                            , ( "pure-button pure-button-primary", True )
                            ]
                        , disabled (not zipcodeIsValid)
                        ]
                        [ text "Continue" ]
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
