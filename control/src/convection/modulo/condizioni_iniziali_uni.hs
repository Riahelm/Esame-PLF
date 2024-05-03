module CondizioniIniziali where

import CondInizialiConv 
import CondInizialiBurg

condizioneIniziale :: Int -> (Double -> Double) -> Double -> [Double]
condizioneIniziale nx onda lmtInf lmtSup = [onda x | x <- lx]
        where
          lx = calcPuntiEqui 0 nx lmtInf lmtSup
