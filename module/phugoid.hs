module Main where

import Data.List

main :: IO ()
main = do putStrLn "Inserisci la larghezza del passo temporale: "
          dt <- getLine 
          let zt    = 100   {- Dato simulazione: profondità al di sotto di una linea orizzonatale di riferimento -}
          let g     = 9.81  {- Dato simulazione accelerazione di gravità -}
          let z0    = 100.0 {- Dato aliante: altitudine -}
          let b0    = 10.0  {- Dato aliante: velocità ascendente risultante dalla raffica -}
          let t     = 100.0 {- Tempo di volo finale -}
          let nt    = calcNumPassi t dt
          putStrLn $ show (calcEulero (z0, b0) (zt, g) dt 0 nt )

-- mainEuler :: (Num a, Fractional a, Floating a) => [Dati a]
-- mainEuler = calcEulero (1000.0, 10.0) (100, 9.81) 0.1 0 1000 

type Dati a = (a,a)

{- numero di passi temporali -}
calcNumPassi :: Float -> Float -> Int
calcNumPassi = t dt = t / dt

estrai :: [Dati a] -> Int -> Dati a
estrai (x:xs) 0 = x
estrai (_:xs) i = estrai xs (i-1)

linspace :: Int -> Double -> Double -> Double -> [Double]
linspace i low up pts | i >= 0    = low : linspace (i - 1) (low + (up / pts)) up pts
                      | otherwise = []

sommaTupla :: (Num a) => Dati a -> Dati a -> Dati a
sommaTupla (a1,b1) (a2,b2) = (a1+a2, b1+b2)

moltiplicaTupla :: (Num a) => Dati a -> Dati a -> Dati a
moltiplicaTupla (a1,b1) (a2,b2) = (a1*a2, b1*b2)

moltiplicaTuplaPerScalare :: (Num a) => Dati a -> a -> Dati a
moltiplicaTuplaPerScalare (a1,b1) b = (a1*b, b1*b)

rhs :: (Num a, Floating a) => Dati a -> Dati a-> Dati a
rhs (y@altitude, v@velocity) (cG@costGrav, zt) =(v,cG * (1-y/zt))

metodoEulero :: (Num a, Floating a) => Dati a -> Dati a -> a -> Dati a
metodoEulero dA@datiAliante dS@datiSimulazione dt = sommaTupla dA (moltiplicaTuplaPerScalare (rhs dA dS) dt)

calcEulero :: (Num a, Floating a) => Dati a -> Dati a -> a -> Int -> Int -> [Dati a]
calcEulero dA@datiAliante dS@datiSimulazione dt i len   | i == 0            = dA : calcolaProssimoPunto
                                                        | i == (len - 1)    = [dA2]
                                                        | otherwise         = dA2 : calcolaProssimoPunto
                                                        where
                                                            dA2 = metodoEulero dA dS dt 
                                                            calcolaProssimoPunto = calcEulero dA2 dS dt (i+1) len