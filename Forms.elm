module MainForm exposing (..)

import Html exposing (..)
import Html.App exposing (beginnerProgram)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onSubmit, onClick)
import Zipcode


type alias Model =
    { zipcode : Maybe String
    , zipcodeEntry : String
    , departmentType : Maybe DepartmentType
    }


type DepartmentType
    = PoliceDepartment
    | SheriffDepartment


type Msg
    = ZipcodeChanged String
    | SubmitZipcode
    | ChooseDepartmentType DepartmentType



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

        ChooseDepartmentType departmentType ->
            { model | departmentType = Just departmentType }



-- model


initialModel : Model
initialModel =
    { zipcode = Nothing
    , zipcodeEntry = ""
    , departmentType = Nothing
    }


debuggingModel : Model
debuggingModel =
    { initialModel
        | zipcode = Just "11211"
    }



-- view


zipcodeForm : String -> Html Msg
zipcodeForm zipcodeEntry =
    let
        zipcodeIsValid =
            Zipcode.isValid zipcodeEntry
    in
        Html.div [ class "pure-form pure-form-aligned", onSubmit SubmitZipcode ]
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


departmentTypeForm : Html Msg
departmentTypeForm =
    Html.div [ class "pure-form" ]
        [ h1 [ style [ ( "fontFamily", "monospace" ) ] ] [ text "Which kind of authorities exist in your area?" ]
        , button
            [ type' "submit"
            , style [ ( "padding", "20px" ), ( "display", "block" ), ( "margin", "20px auto" ) ]
            , classList [ ( "pure-button", True ) ]
            , onClick (ChooseDepartmentType PoliceDepartment)
            ]
            [ text "Police Department" ]
        , button
            [ type' "submit"
            , style [ ( "padding", "20px" ), ( "display", "block" ), ( "margin", "20px auto" ) ]
            , classList [ ( "pure-button", True ) ]
            , onClick (ChooseDepartmentType SheriffDepartment)
            ]
            [ text "Sheriff Department" ]
        ]


view : Model -> Html Msg
view model =
    case model.zipcode of
        Nothing ->
            zipcodeForm model.zipcodeEntry

        Just zipcode ->
            case model.departmentType of
                Nothing ->
                    departmentTypeForm

                Just PoliceDepartment ->
                    text "POLICE!!!"

                Just SheriffDepartment ->
                    text "Sheriff!!!"


main : Program Never
main =
    Html.App.beginnerProgram
        { model = debuggingModel
        , view = view
        , update = update
        }
