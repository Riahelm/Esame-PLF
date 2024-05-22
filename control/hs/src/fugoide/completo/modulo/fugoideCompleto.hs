module FugoideCompleto(main_fugoide_completo) where

import Quadrupla           
import CondizioniComplete
import DatiCompleti

{-  Funzione per il calcolo del moto fugoide con attrito di un velivolo generico.   
    Dati di input: un numero di tipo floating-point, rappresenta il "dt" ovvero l'incremento di tempo per ogni calcolo. 
    Questo si puo' ridurre per avere una precisione di calcolo maggiore. 
    Dati di output: Lista di numeri floating-point, rappresenta l'altitudine del velivolo per ogni singolo 
    incremento temporale calcolato. 
-}
main_fugoide_completo :: Float -> [Float]
main_fugoide_completo dt  = y0 : calc_moto (v0, theta0, x0, y0) dt passiTemporali
   where
      v0                = vTrim           -- La velocita' iniziale, in questo caso quella di trim
      theta0            = 0.0             -- Angolo iniziale del velivolo
      x0                = 0.0             -- Spostamento orizzontale iniziale del velivolo
      y0                = 1000.0          -- Altitudine iniziale del velivolo
      tempo             = 100.0           -- Numero di secondi di simulazione
      passiTemporali    = floor(tempo/dt) -- Numero di punti in cui effettuare il calcolo

{-  Funzione per il calcolo numerico dell'integrazione del moto fugoide 
        Dati di input:  una quadrupla di numeri floating-point, questi sono velocita', angolo, spostamento laterale e verticale del velivolo,
                        un numero floating-point, il dt. Questo e' il passo temporale,
                        un numero intero, rappresenta il numero di passi che sono ancora da effettuare.
        Dati di output: lista di numeri floating-point, questi sono l'altitudine del velivolo per ogni passo temporale. 

    La funzione e' ricorsiva e si divide in caso base e caso generale:
        *Caso base: se il numero di passi temporali e' pari a zero si restituisce la funzione traiettoria del moto fugoide 
        *Caso generale: altrimenti si applica il metodo di Eulero per il calcolo della posizione del velivolo in base 
                        alla posizione nel tempo precedente, si aggiunge l'altitudine alla lista di elementi da ritornare,
                        si abbassa di uno il numero di elementi da calcolare e si procede ricorsivamente con la posizione del
                        velivolo ricalcolata 
-}
calc_moto :: Quadrupla Float -> Float -> Int -> [Float]
calc_moto dA dt len | len == 0                  = [dBD]
                    | otherwise                 = dBD : calcola_prossimo_punto
                    where
                        dB@(_,_,_, dBD)         = metodo_eulero dA dt
                        calcola_prossimo_punto  = calc_moto dB dt (len - 1)

{-  Funzione per l'applicazione del metodo di Eulero ad una quadrupla di numeri. La funzione approssima la soluzione
    al tempo t_(n+1) tramite il valore della funzione al tempo t_n ed un opportuno passo temporale.
    Dati in ingresso:   una quadrupla di numeri floating-point, ovvero la velocita', angolo, spostamento laterale e verticale
                        del velivolo al momento t_n,
                        un numero floating-point, il passo temporale.
    Dati in uscita:     una quadrupla di numeri floating-point, ovvero la velocita', angolo, spostamento laterale e verticale 
                        del velivolo al momento t_(n+1) 
-}
metodo_eulero :: Quadrupla Float -> Float -> Quadrupla Float
metodo_eulero dA@(v,theta,x,y) dt = somma_quadrupla dA (moltiplica_quadrupla_per_scalare (rhs dA) dt)

{-  Funzione per l'applicazione dell'equazione del moto fugoide
    Dati in ingresso:   una quadrupla di numeri floating-point, ovvero la velocita', angolo, spostamento laterale e verticale 
                        del velivolo.
    Dati in uscita:     una quadrupla di numeri floating-point, ovvero la velocita', angolo, spostamento laterale e verticale 
                        del velivolo dopo aver applicato l'equazione per il moto fugoide
-}
rhs :: Quadrupla Float -> Quadrupla Float
rhs dA@(v,theta,x,y) = (- (cG * sin theta) - (cR / cP)*cG/vTrim**2*v**2,
                        - (cG * cos theta / v) + cG/vTrim**2*v,
                        v*cos theta,
                        v*sin theta)
   where
      cG = 9.81   -- Costante gravitazionale terrestre
      cR = 0.025  -- Coefficiente di resistenza all'aria
      cP = 1.0    -- Coefficiente di portanza
