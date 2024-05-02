module Fugoide(mainFugoide) where

import Quadrupla
import CondizioniIniziali
import DatiProblema

mainFugoide :: Float -> [Float] -- attenzione: solo un parametro in ingresso: dt !!
mainFugoide dt = y0 : calcMoto (v0, theta0, x0, y0) dt passiTemporali
   where
      v0 = 30.0
      theta0 = 0.0
      x0 = 0.0
      y0 = 1000.0
      passiTemporali = floor(tempo/dt)

                                                                   -- vedi dispense per utilizzo corretto di fromIntegral

calcMoto :: Quadrupla Float -> Float -> Int -> [Float]
calcMoto dA dt 0     =  [dBA]
                        where
                           (dBA,_,_,_) = metodoEulero dA dt                    

calcMoto dA dt len   =  dBA : calcolaProssimoPunto
                        where
                           dB@(dBA,_,_,_) = metodoEulero dA dt
                           calcolaProssimoPunto = calcMoto dB dt (len - 1)

metodoEulero :: Quadrupla Float -> Float -> Quadrupla Float
metodoEulero dA@(v,theta,x,y) dt = sommaQuadrupla dA (moltiplicaQuadruplaPerScalare (rhs dA) dt)
                                 where 
                                   {- inserisci i dati del problema qui -}
                                   rhs = (- (cG * sin theta) - (cR / cP)*cG/vT**2*v**2,
                                         - (cG * cos theta / v) + cG/vT**2*v,
                                         v*cos theta,
                                         v*sin theta)
{-

--forma più concisa...

mainFugoide :: Float -> Int -> [Float]
mainFugoide dt t@finalTime = y0 : calcMoto (vT, theta0, x0, y0) dt floor (fromIntegral t/dt)
                           -- where
                                {- inserisci condizioni iniziali qui & nt = fromIntegral t/dt-}

calcMoto :: Quadrupla Float -> Float -> Int -> [Float]
calcMoto dA dt 0     =  [dBA]
calcMoto dA dt len   =  dBA : calcolaProssimoPunto
                        where
                           (dBA,_,_,_)          = metodoEulero dA dt    
                           dB@(dBA,_,_,_)       = metodoEulero dA dt
                           calcolaProssimoPunto = calcMoto dB dt (len - 1)


metodoEulero :: Quadrupla Float -> Float -> Quadrupla Float
metodoEulero dA@(v,theta,x,y) dt = sommaQuadrupla dA (moltiplicaQuadruplaPerScalare (rhs dA) dt)
                                 where 
                                   {- inserisci i dati del problema qui -}
                                   rhs = (- (cG * sin theta) - (cR / cP)*cG/vT**2*v**2,
                                         - (cG * cos theta / v) + cG/vT**2*v,
                                         v*cos theta,
                                         v*sin theta)
                                                    

-}

   

