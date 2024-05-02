module FugoideSemplice(mainFugoide) where

import DatiProblema
import CondizioniIniziali
import Coppia

mainFugoide :: Float -> [Float]
mainFugoide dt = z0 : calcMoto (z0, b0) dt 
    where
        z0 = 100.0
        b0 = 10.0

calcMoto :: Coppia Float -> Float -> Int -> [Float]
calcMoto dA dt 0 = [dBA]
    where 
        (dBA,_) = metodoEulero dA dt
calcMoto dA dt len = dBA : calcolaProssimoPunto
    where
        dB@(dBA,_)              = metodoEulero dA dt
        calcolaProssimoPunto    = calcMoto dB dt (len - 1)



metodoEulero :: Coppia Float -> Float -> Coppia Float
metodoEulero dA@(y@altitudine, v@velocita) dt = sommaCoppia dA (moltiplicaCoppiaPerScalare (rhs dA) dt)
    where
        cG = 9.81
        zt = 100.0
        rhs = (v, cG * (1-y/zt))


