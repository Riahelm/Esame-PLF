module Funzionalita where

{- Funzione che calcola la lunghezza di una lista -}
lunghezza :: [a] -> Int
lunghezza []        = 0
lunghezza (x:xs)    = 1 + lunghezza xs

{- Funzione che estrae l'n-esimo elemento di una lista -}
estrai :: [Double] -> Int -> Double
estrai (x:xs) 0 = x
estrai (_:xs) i = estrai xs (i-1)

{- Funzione che genera un numero finito di punti tutti equidistanti tra loro in un intervallo specificato -}
calcPuntiEqui :: Int -> Int -> Double -> Double -> [Double]
calcPuntiEqui i nx inf sup  | i == nx    = [sup]
                            | otherwise  = inf : calcPuntiEqui (i + 1) nx (inf + (sup / fromIntegral(nx :: Int))) sup 
