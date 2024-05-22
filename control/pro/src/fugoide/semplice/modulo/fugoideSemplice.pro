/*  Predicato per il calcolo del moto fugoide privo di attrito di un velivolo generico.   
        Dati in ingresso:   un numero di tipo floating-point, rappresenta il "dt" ovvero l'incremento di tempo per ogni calcolo. 
                            Questo si puo' ridurre per avere una precisione di calcolo maggiore. 
        Dati in uscita:     lista di numeri floating-point, rappresenta l'altitudine del velivolo per ogni singolo 
                            incremento temporale calcolato.
*/
main_fugoide_semplice(DT, [Z0 | T]) :-  Z0 is 100.0,                    /* Altitudine iniziale del velivolo*/
                                        B0 is 10.0,                     /* Angolo iniziale del velivolo */
                                        PASSI is (floor(100.0/DT)- 1),  /* Numero di punti in cui effettuare il calcolo */
                                        calc_moto(Z0, B0, DT, PASSI, T).

/* Predicato per il calcolo numerico dell'integrazione del moto fugoide 
        Dati in ingresso:   una coppia di numeri floating-point, questi sono altitudine e velocita' del velivolo,
                            un numero floating-point, il dt. Questo e' il passo temporale,
                            un numero intero, rappresenta il numero di passi che sono ancora da effettuare.
        Dati in uscita:     lista di numeri floating-point, questi sono l'altitudine del velivolo per ogni passo temporale. 
        
    Il predicato si divide in un fatto e una regola:
            *Fatto:     se il numero di passi temporali e' pari a zero si restituisce la funzione traiettoria del moto fugoide 
            *Regola:    altrimenti si applica il metodo di Eulero per il calcolo della posizione del velivolo in base 
                        alla posizione nel tempo precedente, si aggiunge l'altitudine alla lista di elementi T,
                        si abbassa di uno il numero di elementi da calcolare e si procede ricorsivamente con la posizione del
                        velivolo ricalcolata 
*/
calc_moto(Y, V, DT, 0, [YT])       :-   metodo_eulero(Y, V, DT, YT, _).  
calc_moto(Y, V, DT, LEN, [YT | T]) :-   LEN > 0,
                                        metodo_eulero(Y, V, DT, YT, VT),
                                        LEN1 is (LEN - 1),
                                        calc_moto(YT, VT, DT, LEN1, T).

/*  Predicato per l'applicazione del metodo di Eulero ad una coppia di numeri. Il predicato approssima la soluzione
    al tempo t_(n+1) tramite il valore del predicato al tempo t_n ed un opportuno passo temporale.
        Dati in ingresso:   una coppia di numeri floating-point, ovvero la posizione e direzione del velivolo al momento t_n,
                            un numero floating-point, il passo temporale.
        Dati in uscita:     una coppia di numeri floating-point, ovvero la posizione e direzione del velivolo al momento t_(n+1).
*/
metodo_eulero(Y, V, DT, Y1, V1) :-  rhs(Y, V, YT, VT),
                                    Y1 is (Y + (YT * DT)),
                                    V1 is (V + (VT * DT)). 

/*  Predicato per l'applicazione dell'equazione del moto fugoide
        Dati in ingresso:   una coppia di numeri floating-point, ovvero altitudine e angolazione del velivolo.
        Dati in uscita:     una coppia di numeri floating-point, ovvero altitudine e angolazione del velivolo dopo
                            aver applicato l'equazione per il moto fugoide
*/
rhs(Y, V, V, V1) :- CG is 9.81,     /* Costante gravitazionale terrestre */
                    ZT is 100.0,    /* Altitudine centrale all'oscillazione */
                    V1 is CG * (1-Y/ZT). 
