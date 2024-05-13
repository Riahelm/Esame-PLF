module FugoideSemplice where

import Coppia
import qualified DatiFugoide as DF         
import qualified CondizioniInizialiFugoide as CIF
import AusFun

{-  Funzione per il calcolo del moto fugoide privo di attrito di un velivolo generico.   
    Dati di input: un numero di tipo floating-point => Rappresenta il "dt" ovvero l'incremento di tempo per ogni calcolo. 
    Questo si puo' ridurre per avere una precisione di calcolo maggiore. 
    Dati di output: Lista di numeri floating-point => Rappresenta l'altitudine del velivolo per ogni singolo 
    incremento temporale calcolato. -}
mainFugoideSemplice :: Float -> [Float]
mainFugoideSemplice dt  = y0 : calcMoto (y0, theta0) dt (passiTemporali - 1)
    where
        theta0          = CIF.theta0              -- Angolo iniziale del velivolo
        y0              = CIF.y0             -- Altitudine iniziale del velivolo
        tempo           = DF.tempo             -- Numero di secondi di simulazione
        passiTemporali  = floor(tempo/dt)   -- Numero di punti in cui effettuare il calcolo