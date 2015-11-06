module Main where

import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Color exposing (..)

import Keyboard
import Window
import Time


-- MODEL

type alias Model =
  { posX: Int
  , posY: Int
  }


initialShip : Model
initialShip =
  { posX = 0
  , posY = 0
  }

-- UPDATE

boost : Int
boost = 5


update : { a | x : Int, y : Int } -> Model -> Model
update point ship =
  { ship
  | posX <- ship.posX + point.x * boost
  , posY <- ship.posY + point.y * boost
  }

-- VIEW

view : (Int, Int) -> Model -> Element
view (w, h) ship =
  let
    (w', h') = (toFloat w, toFloat h)
  in
    collage w h
      [ drawGame w' h'
      , drawShip h' ship
      ]


drawGame : Float -> Float -> Form
drawGame w h =
  rect w h
    |> filled gray


drawShip : Float -> Model -> Form
drawShip gameHeight ship =
   circle 20
     |> filled blue
     |> rotate (degrees 90)
     |> move ((toFloat ship.posX), (toFloat ship.posY))


direction : Signal { x : Int, y : Int }
direction =
  let
    delta = Time.fps 30
  in
    Signal.sampleOn delta Keyboard.arrows

-- MAIN

main : Signal Element
main =
  Signal.map2 view Window.dimensions <| Signal.foldp update initialShip direction
