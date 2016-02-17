module Pages.Register.View where
import Pages.Register.Model exposing (..)

import View.Helpers exposing (..)

import Form exposing (Form)
import Form.Input as Input

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


view : Signal.Address Action -> Model -> Html
view address model =
        let
            formAddress = Signal.forwardTo address FormAction

            errorFor field =
                case field.liveError of
                    Just error ->
                        div [ class "error" ] [ text (toString error) ]
                    Nothing ->
                        text ""
            email = Form.getFieldAsString "email" model.form
            password = Form.getFieldAsString "password" model.form
            clickEvent = case Form.getOutput model.form of
                Just registration ->
                    onClick address (SubmitRegister registration)
                Nothing ->
                    onClick formAddress Form.submit
        in
            div [ class "row" ]
                [ Html.form [ class "col s6 offset-s3" ] 
                    [ div [ class "row" ] 
                        [ emailFormField model formAddress
                        , passwordFormField model formAddress
                        , nonFieldErrorsView model
                        , button
                            [ clickEvent 
                            , class "waves-effect waves-light btn right-align"
                            , type' "button"
                            ]
                            [ text "Register" ]
                        ]
                     ]
                 ]
