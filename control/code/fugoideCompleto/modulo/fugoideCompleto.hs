module Fugoide(mainFugoide) where

import qualified Funzionalita 
import qualified CondizioniIniziali 
import qualified DatiProblema 

mainFugoide :: (Num a, Fractional a, Floating a) => a -> Int-> [a]
mainFugoide dt t@finalTime = y0 : calcMoto (vT, theta0, x0, y0) dt t/dt

calcMoto :: (Num a, Floating a) => Dati a -> a -> Int -> [a]
calcMoto dA dS dt 0 = [dBA]
                        where
                           (dBA,_,_,_) = metodoEulero dA dS dt
calcMoto dA dS@datiSimulazione dt len = dBA : calcolaProssimoPunto
                                          where
                                             dB@(dBA,_,_,_) = metodoEulero dA dS dt 
                                             calcolaProssimoPunto = calcMoto dB dS dt (len - 1)

rhs :: (Num a, Floating a) => Dati a -> Dati a
rhs (v,theta,x,y) =  (- (cG * sin theta) - (cR / cP)*cG/vT**2*v**2,
                     - (cG * cos theta / v) + cG/vT**2*v,
                     v*cos theta,
                     v*sin theta)

metodoEulero :: (Num a, Floating a) => Dati a -> Dati a -> a -> Dati a
metodoEulero dA@datiAliante dS@datiSimulazione dt = sommaTupla dA (moltiplicaTuplaPerScalare (rhs dA dS) dt)

