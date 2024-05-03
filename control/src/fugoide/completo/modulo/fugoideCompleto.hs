module FugoideCompleto(mainFugoideCompleto) where

import Quadrupla
import CondizioniComplete
import DatiCompleti

mainFugoideCompleto :: Float -> [Float]
mainFugoideCompleto dt  = y0 : calcMoto (v0, theta0, x0, y0) dt passiTemporali
   where
      v0                = vTrim
      theta0            = 0.0
      x0                = 0.0
      y0                = 1000.0
      tempo             = 100.0
      passiTemporali    = floor(tempo/dt)

calcMoto :: Quadrupla Float -> Float -> Int -> [Float]
calcMoto dA dt 0           =  [dAD]         
   where
      (_,_,_, dAD)         = metodoEulero dA dt
calcMoto dA dt len         =  dAD : calcolaProssimoPunto
   where
      dB@(_,_,_, dAD)      = metodoEulero dA dt
      calcolaProssimoPunto = calcMoto dB dt (len - 1)

metodoEulero :: Quadrupla Float -> Float -> Quadrupla Float
metodoEulero dA@(v,theta,x,y) dt = sommaQuadrupla dA (moltiplicaQuadruplaPerScalare (rhs dA) dt)

rhs :: Quadrupla Float -> Quadrupla Float
rhs dA@(v,theta,x,y) = (- (cG * sin theta) - (cR / cP)*cG/vTrim**2*v**2,
                        - (cG * cos theta / v) + cG/vTrim**2*v,
                        v*cos theta,
                        v*sin theta)
   where
      cG = 9.81
      cR = 0.025
      cP = 1.0