module Funzionalita where

import Data.List

{- Funzione che genera un numero finito di punti tutti equidistanti tra loro in un intervallo specificato -}

calcPuntiEqui :: Int -> Double -> Double -> [Double]
calcPuntiEqui 0 _ _      = []
calcPuntiEqui nx inf sup = calcPunti 0 (nx - 1) inf (sup  - inf) 

calcPunti :: Int -> Int -> Double -> Double -> [Double]
calcPunti i nx inf dst | i == nx   = [inf]
                       | otherwise = inf : calcPunti (i + 1) nx (inf + (dst / fromIntegral(nx :: Int))) dst
