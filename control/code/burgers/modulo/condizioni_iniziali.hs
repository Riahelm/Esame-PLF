module CondIniziali where

import Funzionalita 
import Parametri

{- Calcolo della condizione iniziale per la risoluzione dell'equazione di Burgers a una dimensione. La con-
   -dizione iniziale viene imposta al tempo t=0 e consiste nel calcolo della funzione 'u' a dente di sega. -}

condizioneIniziale :: [Double] -> Double -> Double -> [Double]
condizioneIniziale lx t nu = [u tInizio x nu | x <- lx]