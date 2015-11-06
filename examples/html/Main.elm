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
  h2 [] [ text "Elm HTML Example" ]

currentValue : Int -> Html
currentValue value =
  let
    valueText = "The current value is: " ++ (toString value)
  in
    span [] [ text valueText ]

counterButtons : Address Action -> Html
counterButtons address =
  div []
      [ button [ onClick address Increment ] [ text "+"]
      , button [ onClick address Decrement ] [ text "-"]
      ]

resetButtons : Address Action -> Html
resetButtons address =
  div []
      [ button [onClick address ResetValue]
               [ text "Reset" ]
      , button [onClick address ResetAll]
               [ text "Reset All" ]
      ]

totalOps : Int -> Html
totalOps value =
  let
    opsText = "Number of operations: " ++ (toString value)
  in
    span [] [ text opsText ]

view : Address Action -> Model -> Html
view address model =
  div [ id "container" ]
      [ pageHeader
      , currentValue model.value
      , counterButtons address
      , resetButtons address
      , totalOps model.opCount
      ]

-- MAIN

main : Signal Html
main =
  StartApp.start
    { model = initialModel
    , view = view
    , update = update
    }
