module Burgers(main_burgers) where

import Funzionalita
import Parametri
import CondIniziali

{- Funzione per il calcolo dell'equazione di Burgers unidimensionale -}
main_burgers :: Int -> [Double]
main_burgers nx = calcConvTempo (condizioneIniziale nx lmtInf lmtSup) nt nx nu dx dt

{- Funzione per il calcolo numerico dell'integrazione dell'equazione di Burgers unidimensionale rispetto al tempo:
    *Caso base: se il numero di passi temporali è pari a zero, allora si restituisce la funzione a dente di sega.
    *Caso generale: altrimenti si integra numericamente la funzione 'u' rispetto allo spazio, si decrementa di una
    unità il numero di passi totale e si procede ricorsivamente con la funzione d'onda ricalcolata.-}
calcConvTempo :: [Double] -> Int -> Int -> Double -> Double -> Double -> [Double]
calcConvTempo onda 0 _ _ _ _            = onda
calcConvTempo onda nt nx nu dx dt = calcConvTempo (x : calcConvSpazio onda 1 nu dx dt) (nt - 1) nx nu dx dt
                                       where  
                                        x = head onda - head onda * dt/dx * (head onda - last onda) + 
                                            nu*dt/dx**2 * ((head $ tail onda) - 2*(head onda) + last onda) -- condizione di bordo inferiore

{- Funzione per il calcolo numerico dell'integrazione dell'equazione di burgers unidimensionale rispetto allo spazio:
    *Caso base: se il numero corrente di passi spaziali è pari al numero complessivo di passi spaziali, allora la funzione ese-
    -gue un passo di Eulero (Euler'step) sulla condizione di bordo "superiore".
    *Caso generale: altrimenti si esegue un passo di Eulero, si incrementa di un'unità il numero di passi spaziali e si procede 
     ricorsivamente sulla medesima lista di punti. -}
calcConvSpazio :: [Double] -> Int -> Double -> Double -> Double -> [Double]
calcConvSpazio lx i un dx dt  | i == length lx - 1 = [condBordoSup]
                              | otherwise          = (passoEulero) : calcConvSpazio lx (i+1) un dx dt
                                  where
                                    condBordoSup = (last lx) - (last lx) * dt/dx * ((last lx) - (last $ init lx)) + nu*dt/dx**2*(head lx - 2*(last lx) + (last $ init lx))
                                    passoEulero  = (lx !! i - lx !! i * dt/dx * (lx !! i - lx !! (i-1)) + nu*dt/dx**2*(lx !! (i+1) - 2*(lx !! i) + lx !! (i-1))) 

                        
                                
