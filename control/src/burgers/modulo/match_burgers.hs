module MatchBurgers(main_burgers) where

import Funzionalita
import ParametriBurg
import CondInizialiBurg

type Dati a = (a,a,a)


main_burgers :: Int -> [Double]
main_burgers nx = calcConvTempo onda nt (condBordoInf) 
                                        (condBordoSup) 
                                        (passoEulero)
                     where
                       onda = condizioneIniziale nx lmtInf lmtSup
                       lmtInf = 0.0                                -- limite inferiore del dominio spaziale 
                       lmtSup = 2.0 * pi                           -- limite superiore del dominio spaziale 
                       dx = lmtSup / (fromIntegral(nx :: Int) - 1) -- distanza tra qualsiasi coppia di punti della griglia adiacenti 
                       sigma = 0.1                                 -- costante di Courant-Friedrichs_Lewy (CFL)
                       dt = sigma * dx**2 / nu                     -- lunghezza del passo temporale 
                       tFine = 0.6                                 -- tempo totale di simulazione 
                       nt = truncate(tFine / dt)                   -- numero complessivo di passi temporali che deve effettuare l'algoritmo 


calcConvTempo :: [Double] -> Int -> ([Double] -> Double) -> 
                                    ([Double] -> Double) -> 
                                    ([Double] -> Int -> Double) -> [Double]

calcConvTempo onda 0 _ _ _       = onda
calcConvTempo onda nt inf sup pe = calcConvTempo ((inf onda): calcConvSpazio onda 1 sup pe) (nt - 1) inf sup pe 

calcConvSpazio :: [Double] -> Int -> ([Double] -> Double) -> 
                                     ([Double] -> Int -> Double) -> [Double]

calcConvSpazio lx i sup pe | i == length lx - 1 = [sup lx]
                           | otherwise          = (pe lx i) : calcConvSpazio lx (i+1) sup pe 

condBordoInf :: [Double] -> Double
condBordoInf onda = head onda - head onda * dt/dx * (head onda - last onda) + 
                    nu*dt/dx**2 * ((head $ tail onda) - 2*(head onda) + last onda)
            
condBordoSup :: [Double] -> Double
condBordoSup lx = (last lx) - (last lx) * dt/dx * ((last lx) - (last $ init lx)) + 
                  nu*dt/dx**2*(head lx - 2*(last lx) + (last $ init lx))

passoEulero :: [Double] -> Int -> Double
passoEulero lx i  = (lx !! i - lx !! i * dt/dx * (lx !! i - lx !! (i-1)) + 
                    nu*dt/dx**2*(lx !! (i+1) - 2*(lx !! i) + lx !! (i-1))) 
