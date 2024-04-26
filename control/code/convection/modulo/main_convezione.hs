module Convezione where

import Funzionalita
import Parametri
import CondIniziali


{- Funzione per il calcolo dell'equazione di convezione lineare unidimensionale -}
main_convezione = calcConveTempo (condizioneIniziale nt nx c dx dt)

{- Funzione per il calcolo numerico dell'integrazione dell'equazione di convezione lineare unidimensionale rispetto al tempo:
    *Caso base: se il numero di passi temporali è pari a zero, allora si restituisce la funzione d'onda quadra.
    *Caso generale: altrimenti si integra numericamente la funzione d'onda quadra rispetto allo spazio, si decrementa di una
    unità il numero di passi totale e si procede ricorsivamente con la funzione d'onda ricalcolata.-}
calcConvTempo :: [Double] -> Int -> Int -> Double -> Double -> Double -> [Double]
calcConvTempo  onda 0 _ _ _ _           = onda
calcConveTempo onda@(x:_) nt nx c dx dt = calcConvTempo (x : calcConvSpazio onda 1 c dx dt) (nt - 1) nx c dx dt

{- Funzione per il calcolo numerico dell'integrazione dell'equazione di convezione lineare unidimensionale rispetto allo spazio:
    *Caso base: se il numero corrente di passi spaziali è pari al numero complessivo di passi spaziali, allora la funzione ese-
    -gue un passo di Eulero (Euler'step).
    *Caso generale: altrimenti si esegue un passo di Eulero, si incrementa di un'unità il numero di passi spaziali e si procede 
     ricorsivamente sulla medesima lista di punti. -}
calcConvSpazio :: [Double] -> Int -> Double -> Double -> Double -> [Double]
calcConvSpazio lx@(x:_) i c dx dt  | i == lunghezza lx - 1 = [passoEulero]
                                   | otherwise             = (passoEulero) : calcConvSpazio lx (i+1) c dx dt
                                      where
                                        passoEulero = estrai lx i - c * dt /dx *(estrai lx i - estrai lx (i-1))

    