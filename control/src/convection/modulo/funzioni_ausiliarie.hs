module Funzionalita where

import Data.List

{- Funzione che genera un numero finito di punti tutti equidistanti tra loro in un intervallo specificato -}
calcPuntiEqui :: Int -> Int -> Double -> Double -> [Double]
calcPuntiEqui i nx inf sup  | i == nx    = []
                            | otherwise  = inf : calcPuntiEqui (i + 1) nx (inf + (sup / fromIntegral(nx :: Int))) sup 
