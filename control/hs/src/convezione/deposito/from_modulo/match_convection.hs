module MatchCOnvezione(main_convezione) where

import Funzionalita
import Parametri
import CondInizialiConv

type Dati a = (a,a)

main_convezione :: Int -> Double -> [Double]                                        -- condBordo
main_convezione nx dt = calcConvTempo (condizioneIniziale nx lmtInf lmtSup) nt (dx,dt) passoEulero passoEulero -- numero parametri differente...
                            where
                              lmtInf = 0.0                                -- limite inferiore del dominio spaziale 
                              lmtSup = 2.0                                -- limite superiore del dominio spaziale
                              nt = 25                                     -- numero complessivo di passi temporali che deve effettuare l'algoritmo 
                              dx = lmtSup / (fromIntegral(nx :: Int) - 1) -- distanza tra qualsiasi coppia di punti della griglia adiacenti 
                           -- c  = 1.0                                    -- velocità dell'onda 


passoEulero :: [Double] ->  Int -> Dati Double -> Double
passoEulero lx i (dx,dt) =  lx !! i - c * dt /dx *(lx !! i - lx !! (i-1))