module CondIniziali where

import Funzionalita 
import Parametri

{- Calcolo della condizione iniziale per la risoluzione dell'equazione di convezione lineare a una dimensione. 
   La condizione iniziale viene imposta al tempo t=0 e consiste nel calcolo della funzione d'onda quadra. -}
condizioneIniziale :: Int -> [Double]
condizioneIniziale nx = calcOndaQuadra (calcPuntiEqui 0 nx limiteInf limiteSup) ondaInf ondaSup

{- Funzione che definisce l'onda quadra: il domiino della funzione è rappresentato da un insieme finito di
   punti tra 0 e 2, estremi compresi. Il coodominio è formato da due valori: 2 (valore assunto da tutti gli 
   elementi del dominio compresi tra 0.5 e 1.0) e 1 (valore assunto dagli elementi del dominio che non fan-
   -no parte dell'intervallo [0.5, 1.0]) -}  -- Nota 1
calcOndaQuadra :: [Double] -> Double -> Double -> [Double]
calcOndaQuadra  [] _ _                                                       = []
calcOndaQuadra  lx@(x:xs) inf sup | lunghezza lx > 0 && x >= 0.5 && x <= 1.0 = sup : calcOndaQuadra xs inf sup
                                  | otherwise                                = inf : calcOndaQuadra xs inf sup
                         

-----------------------------------------------------------------------------------------------------------------
-- Nota 1: le costanti 0.5 e 1.0 sono utilizzate per calcolare l'onda. Il fatto che non siano impostabili
-- dall'utente è una "scelta di progetto".
