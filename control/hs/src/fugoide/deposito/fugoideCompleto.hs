module FugoideCompleto where

import Quadrupla           
import qualified DatiFugoide as DF
import qualified CondizioniInizialiFugoide as CIF
import AusFun
{-  Funzione per il calcolo del moto fugoide con attrito di un velivolo generico.   
    Dati di input: un numero di tipo floating-point => Rappresenta il "dt" ovvero l'incremento di tempo per ogni calcolo. 
    Questo si puo' ridurre per avere una precisione di calcolo maggiore. 
    Dati di output: Lista di numeri floating-point => Rappresenta l'altitudine del velivolo per ogni singolo 
    incremento temporale calcolato. -}
mainFugoideCompleto :: Float -> [Float]
mainFugoideCompleto dt  = y0 : calcMoto (v0, theta0, x0, y0) dt (passiTemporali - 1)
   where
      v0                = vTrim           -- La velocita' iniziale, in questo caso quella di trim
      theta0            = CIF.theta0             -- Angolo iniziale del velivolo
      x0                = 0.0             -- Spostamento orizzontale iniziale del velivolo
      y0                = CIF.y0          -- Altitudine iniziale del velivolo
      tempo             = DF.tempo           -- Numero di secondi di simulazione
      passiTemporali    = floor(DF.tempo/dt) -- Numero di punti in cui effettuare il calcolo