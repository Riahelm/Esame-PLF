module Fugoide(mainFugoide) where

import Funzioni
import CondizioniIniziali
import DatiProblema

mainFugoide :: Float -> Int -> [Float] -- attenzione: solo un parametro in ingresso: dt !!
mainFugoide dt t@finalTime = y0 : calcMoto (vT, theta0, x0, y0) dt (floor (fromIntegral(t :: Int)  / dt))

calcMoto :: Dati Float -> Float -> Int -> [Float]
calcMoto dA dt 0     =  [dBA]
                        where
                           (dBA,_,_,_) = metodoEulero dA dt                    

calcMoto dA dt len   =  dBA : calcolaProssimoPunto
                        where
                           dB@(dBA,_,_,_) = metodoEulero dA dt
                           calcolaProssimoPunto = calcMoto dB dt (len - 1)

rhs :: Dati Float -> Dati Float
rhs (v,theta,x,y) =  (- (cG * sin theta) - (cR / cP)*cG/vT**2*v**2,
                     - (cG * cos theta / v) + cG/vT**2*v,
                     v*cos theta,
                     v*sin theta)

metodoEulero :: Dati Float -> Float -> Dati Float
metodoEulero dA@datiAliante dt = sommaTupla dA (moltiplicaTuplaPerScalare (rhs dA) dt)

{-

--forma più concisa...

mainFugoide :: Float -> Int -> [Float]
mainFugoide dt t@finalTime = y0 : calcMoto (vT, theta0, x0, y0) dt floor (fromIntegral t/dt)
                           -- where
                                {- inserisci condizioni iniziali qui & nt = fromIntegral t/dt-}

calcMoto :: Dati Float -> Float -> Int -> [Float]
calcMoto dA dt 0     =  [dBA]
calcMoto dA dt len   =  dBA : calcolaProssimoPunto
                        where
                           (dBA,_,_,_)          = metodoEulero dA dt    
                           dB@(dBA,_,_,_)       = metodoEulero dA dt
                           calcolaProssimoPunto = calcMoto dB dt (len - 1)


metodoEulero :: Dati Float -> Float -> Dati Float
metodoEulero dA@(v,theta,x,y) dt = sommaTupla dA (moltiplicaTuplaPerScalare (rhs dA) dt)
                                 where 
                                   {- inserisci i dati del problema qui -}
                                   rhs = (- (cG * sin theta) - (cR / cP)*cG/vT**2*v**2,
                                         - (cG * cos theta / v) + cG/vT**2*v,
                                         v*cos theta,
                                         v*sin theta)
                                                    

-}

   

