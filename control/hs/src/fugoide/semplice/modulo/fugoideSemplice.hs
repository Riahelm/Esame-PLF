module FugoideSemplice(main_fugoide_semplice) where

import DatiSemplici         
import CondizioniSemplici
import Coppia

{-  Funzione per il calcolo del moto fugoide privo di attrito di un velivolo generico.   
        Dati di input:  un numero di tipo floating-point, rappresenta il "dt" ovvero l'incremento di tempo per ogni calcolo. 
                        Questo si puo' ridurre per avere una precisione di calcolo maggiore. 
        Dati di output: Lista di numeri floating-point, rappresenta l'altitudine del velivolo per ogni singolo 
                        incremento temporale calcolato. 
-}
main_fugoide_semplice :: Float -> [Float]
main_fugoide_semplice dt  = z0 : calc_moto (z0, b0) dt passi_temporali
    where
        z0              = 100.0               -- Altitudine iniziale del velivolo
        b0              = 10.0                -- Velocita' iniziale del velivolo
        tempo           = 100.0               -- Numero di secondi di simulazione
        passi_temporali = floor(tempo/dt) + 1 -- Numero di punti in cui effettuare il calcolo

{-  Funzione per il calcolo numerico dell'integrazione del moto fugoide 
        Dati di input:  una coppia di numeri floating-point, questi sono altitudine e velocita' del velivolo,
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
calc_moto :: Coppia Float -> Float -> Int -> [Float]
calc_moto dA@(dAA,_) dt len | len == 0                  = [dBA]
                            | otherwise                 = dBA : calcola_prossimo_punto
                            where
                                dB@(dBA,_)              = metodo_eulero dA dt
                                calcola_prossimo_punto  = calc_moto dB dt (len - 1)

{-  Funzione per l'applicazione del metodo di Eulero ad una coppia di numeri. La funzione approssima la soluzione
    al tempo t_(n+1) tramite il valore della funzione al tempo t_n ed un opportuno passo temporale.
        Dati in ingresso:   una coppia di numeri floating-point, ovvero la posizione e direzione del velivolo al momento t_n,
                            un numero floating-point, il passo temporale.
        Dati in uscita:     una coppia di numeri floating-point, ovvero la posizione e direzione del velivolo al momento t_(n+1). 
-}
metodo_eulero :: Coppia Float -> Float -> Coppia Float
metodo_eulero dA@(y@altitudine, v@velocita) dt = somma_coppia dA (moltiplica_coppia_per_scalare (rhs dA) dt)

{-  Funzione per l'applicazione dell'equazione del moto fugoide
        Dati in ingresso:   una coppia di numeri floating-point, ovvero altitudine e angolazione del velivolo.
        Dati in uscita:     una coppia di numeri floating-point, ovvero altitudine e angolazione del velivolo dopo
                            aver applicato l'equazione per il moto fugoide 
-}
rhs :: Coppia Float -> Coppia Float
rhs dA@(y@alt, v@vel)   = (v, cG * (1-y/zt))
    where
        cG              = 9.81  -- Costante gravitazionale terrestre
        zt              = 100.0 -- Altitudine centrale all'oscillazione
