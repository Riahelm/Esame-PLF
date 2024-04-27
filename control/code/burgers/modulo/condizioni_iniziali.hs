module CondIniziali where

import Funzionalita 
import Parametri

{- Calcolo della condizione iniziale per la risoluzione dell'equazione di Burgers a una dimensione. La con-
   -dizione iniziale viene imposta al tempo t=0 e consiste nel calcolo della funzione 'u' a dente di sega. -}
{-
condizioneIniziale :: Int -> Double -> Double -> [Double]
condizioneIniziale = ondaDenteSega (calcPuntiEqui 0 nx lmtInf lmtSup) 
-}

{- Funzione che calcola l'onda a dente di sega 'u'. La funzione 'u' è ottenuta tramite la trasformazione di 
   Cole-Hopf. Per calcolare 'u' si necessita della funzione 'phi' e della sua derivata 'phiprime' rispetto
   alla variabile spaziale 'x' -}
{-
calcOndaDenteSega :: [Double] -> [Double]
calcOndaDenteSega lx = [u t0 x nu | x <- lx] 
                          where 
                            phiprime t0 x nu = -(-8*t + 2*x)*exp(-(-4*t + x)**2/(4*nu*(t + 1)))/(4*nu*(t + 1)) - (-8*t + 2*x - 4*pi)*
                                              exp(-(-4*t + x - 2*pi)**2/(4*nu*(t + 1)))/(4*nu*(t + 1))           -- derivata rispetto a x della funzione phi
                            phi t0 x nu      = exp(-(x-4*t)**2/(4*nu*(t+1))) + exp(-(x-4*t-2*pi)**2/(4*nu*(t+1))) -- funzione phi
                            u t0 x nu        = -2*nu*((phiprime t x nu) / (phi t x nu))+4                         -- funzione a dente di sega 'u'

-}


----------------------------------------------------------------------------------------------------------------------
-- Nota 1: list comprehension: alternativa

condizioneIniziale :: Int -> Double -> Double -> [Double]
condizioneIniziale nx lmtInf lmtSup = [calcOndaDenteSega x | x <- lx]
                                         where
                                           lx = calcPuntiEqui 0 nx lmtInf lmtSup

calcOndaDenteSega :: Double -> Double
calcOndaDenteSega x = u t0 x nu 
                       where 
                         phiprime t0 x nu = -(-8*t + 2*x)*exp(-(-4*t + x)**2/(4*nu*(t + 1)))/(4*nu*(t + 1)) - (-8*t + 2*x - 4*pi)*
                                            exp(-(-4*t + x - 2*pi)**2/(4*nu*(t + 1)))/(4*nu*(t + 1))          -- derivata rispetto alla variabile x della funzione phi
                         phi t0 x nu      = exp(-(x-4*t)**2/(4*nu*(t+1))) + exp(-(x-4*t-2*pi)**2/(4*nu*(t+1))) -- funzione phi
                         u t0 x nu        = -2*nu*((phiprime t x nu) / (phi t x nu))+4  