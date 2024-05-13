module CondInizialiConv(calcOndaQuadra) where

import Funzionalita 
--import Parametri

{- Calcolo della condizione iniziale per la risoluzione dell'equazione di convezione lineare a una dimensione. 
   La condizione iniziale viene imposta al tempo t=0 e consiste nel calcolo della funzione d'onda quadra. -}
--condizioneIniziale :: Int -> Double -> Double -> [Double]
--condizioneIniziale nx lmtInf lmtSup = calcOndaQuadra (calcPuntiEqui 0 nx lmtInf lmtSup) 

{- Funzione che definisce l'onda quadra: il dominio della funzione è rappresentato da un insieme finito di
   punti tra 0 e 2, estremi compresi. Il coodominio è formato da due valori: 2 (valore assunto da tutti gli 
   elementi del dominio compresi tra 0.5 e 1.0) e 1 (valore assunto dagli elementi del dominio che non fan-
   -no parte dell'intervallo [0.5, 1.0]) -}  -- Nota 1
{-
calcOndaQuadra :: [Double] -> [Double]
calcOndaQuadra  []                                                   = []
calcOndaQuadra  lx@(x:xs) | lunghezza lx > 0 && x >= 0.5 && x <= 1.0 = ondaSup : calcOndaQuadra xs 
                          | otherwise                                = ondaInf : calcOndaQuadra xs 
                              where
                                ondaSup = 2.0 -- valori assunti dalla parte alta della funzione d'onda quadra
                                ondaInf = 1.0 -- valori assunti dalla parte bassa della funzione d'onda quadra

-}
-----------------------------------------------------------------------------------------------------------------
-- Nota 1: le costanti 0.5 e 1.0 sono utilizzate per calcolare l'onda. Il fatto che non siano impostabili
-- dall'utente è una "scelta di progetto".

-- Nota 2: list comprehension: alternativa

condizioneIniziale :: Int -> Double -> Double -> [Double]
condizioneIniziale nx lmtInf lmtSup = [calcOndaQuadra x | x <- lx]
                                         where
                                           lx = calcPuntiEqui 0 nx lmtInf lmtSup

calcOndaQuadra :: Double -> Double
calcOndaQuadra x | x >= 0.5 && x <= 1.0 = ondaSup
                 | otherwise            = ondaInf
                     where 
                       ondaSup = 2.0 -- valori assunti dalla parte alta della funzione d'onda quadra
                       ondaInf = 1.0 -- valori assunti dalla parte bassa della funzione d'onda quadra

                                                                  


