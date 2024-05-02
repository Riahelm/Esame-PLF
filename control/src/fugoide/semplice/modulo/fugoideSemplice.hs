module FugoideSemplice(mainFugoideSemplice) where

import DatiSemplici
import CondizioniSemplici
import Coppia

mainFugoideSemplice :: Float -> [Float]
mainFugoideSemplice dt = z0 : calcMoto (z0, b0) dt passiTemporali
    where
        tempo = 100
        z0 = 100.0
        b0 = 10.0
        passiTemporali = floor(fromIntegral tempo/dt)

calcMoto :: Coppia Float -> Float -> Int -> [Float]
calcMoto dA dt 0 = [dBA]
    where 
        (dBA,_)  = metodoEulero dA dt
calcMoto dA dt len              = dBA : calcolaProssimoPunto
    where
        dB@(dBA,_)              = metodoEulero dA dt
        calcolaProssimoPunto    = calcMoto dB dt (len - 1)



metodoEulero :: Coppia Float -> Float -> Coppia Float
metodoEulero dA@(y@altitudine, v@velocita) dt = sommaCoppia dA (moltiplicaCoppiaPerScalare (rhs dA) dt)

rhs :: Coppia Float -> Coppia Float
rhs dA@(y@alt, v@vel)   = (v, cG * (1-y/zt))
    where
        cG              = 9.81
        zt              = 100.0
