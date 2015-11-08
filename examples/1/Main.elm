module Main where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Address)
import StartApp.Simple as StartApp 

type alias Model =
  { value : Int
  , opCount : Int
  }

-- MODEL

initialModel : Model
initialModel =
  { value = 0
  , opCount = 0
  }


-- ACTION

type Action
  = Increment
  | Decrement
  | ResetValue
  | ResetAll

-- UPDATE

stopAtZero : Int -> Int
stopAtZero n =
  case n of
    0 -> 0
    otherwise -> n - 1

update : Action -> Model -> Model
update action model =
  case action of
    Increment ->
      { model | value <- model.value + 1, opCount <- model.opCount + 1 }
    Decrement ->
        { model | value <- stopAtZero model.value, opCount <- model.opCount + 1 }
    ResetValue ->
      { model | value <- 0, opCount <- model.opCount + 1 }
    ResetAll ->
      initialModel

-- VIEW

pageHeader : Html
pageHeader =
  h1 [ class "mui--text-display3"]
     [ text "Elm HTML Example" ]

currentValue : Int -> Html
currentValue value =
  let
    valueText = "The current value is: " ++ (toString value)
  in
    h3 [] [ text valueText ]

counterButtons : Address Action -> Html
counterButtons address =
  div []
      [ button [ onClick address Decrement
               , class buttonClasses
               ]
               [ text "-"]
      , button [ onClick address Increment
               , class buttonClasses
               ]
               [ text "+"]
      ]

buttonClasses : String 
buttonClasses = "mui-btn mui-btn--raised mui-btn--primary"

resetButtons : Address Action -> Html
resetButtons address =
  div [ class "mui--clearfix" ]
      [ button [onClick address ResetAll
               , class resetButtonClasses
               , id "reset-all"
               ]
               [ text "Reset All" ]
      , button [onClick address ResetValue
               , class resetButtonClasses
               , id "reset"
               ]
               [ text "Reset" ]
      ]

resetButtonClasses : String
resetButtonClasses = "mui--pull-right mui-btn mui-btn--raised"

totalOps : Int -> Html
totalOps value =
  let
    opsText = "Number of operations: " ++ (toString value)
  in
    div [ id "ops"
        , class "mui--pull-right"
        ]
        [ text opsText ]

view : Address Action -> Model -> Html
view address model =
  div [ class "mui-container" ]
      [ pageHeader
      , div [ id "container"
            , class "mui-panel"
            ]
            [ currentValue model.value
            , counterButtons address
            , resetButtons address
            , totalOps model.opCount
            ]
      ]

-- MAIN

main : Signal Html
main =
  StartApp.start
    { model = initialModel
    , view = view
    , update = update
    }
