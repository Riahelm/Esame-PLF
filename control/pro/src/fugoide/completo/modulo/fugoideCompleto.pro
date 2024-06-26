/*  Predicato per il calcolo del moto fugoide con attrito di un velivolo generico.   
        Dati in ingresso:   un numero di tipo floating-point, rappresenta il "dt" ovvero l'incremento di tempo per ogni calcolo. 
                            Questo si puo' ridurre per avere una precisione di calcolo maggiore. 
        Dati in uscita:     Lista di numeri floating-point, rappresenta l'altitudine del velivolo per ogni singolo 
                            incremento temporale calcolato.
*/
main_fugoide_completo(DT, [Y0 | T]) :-  V0 is 30.0,                     /* La velocita' iniziale, in questo caso quella di trim */
                                        THETA0 is 0.0,                  /* Angolo iniziale del velivolo */
                                        X0 is 0.0,                      /* Spostamento orizzontale iniziale del velivolo*/
                                        Y0 is 1000.0,                   /* Altitudine iniziale del velivolo */
                                        PASSI is (floor(100.0/DT)+ 1),  /* Numero di punti in cui effettuare il calcolo */
                                        calc_moto(V0, THETA0, X0, Y0, DT, PASSI, T). 

/*  Predicato per il calcolo numerico dell'integrazione del moto fugoide 
        Dati in ingresso:   una quadrupla di numeri floating-point, questi sono velocita', angolo, spostamento laterale e verticale del velivolo,
                            un numero floating-point, il dt. Questo e' il passo temporale,
                            un numero intero, rappresenta il numero di passi che sono ancora da effettuare.
        Dati in uscita:     lista di numeri floating-point, questi sono l'altitudine del velivolo per ogni passo temporale. 

    Il predicato si divide in due regole:
        *Prima regola:      se il numero di passi temporali e' pari a zero si restituisce la funzione traiettoria del moto fugoide 
        *Seconda regola:    altrimenti si applica il metodo di Eulero per il calcolo della posizione del velivolo in base 
                            alla posizione nel tempo precedente, si aggiunge l'altitudine alla lista di elementi T,
                            si abbassa di uno il numero di elementi da calcolare e si procede ricorsivamente con la posizione del
                            velivolo ricalcolata 
*/
calc_moto(V, THETA, X, Y, DT, 0, [Y1])       :- metodo_eulero(V, THETA, X, Y, DT, _, _, _, Y1).  
calc_moto(V, THETA, X, Y, DT, LEN, [Y1 | T]) :- LEN > 0,
                                                metodo_eulero(V, THETA, X, Y, DT, V1, THETA1, X1, Y1),
                                                LEN1 is (LEN - 1),
                                                calc_moto(V1, THETA1, X1, Y1, DT, LEN1, T).

/*  Predicato per l'applicazione del metodo di Eulero ad una quadrupla di numeri. Il predicato approssima la soluzione
    al tempo t_(n+1) tramite il valore del predicato al tempo t_n ed un opportuno passo temporale.
        Dati in ingresso:   una quadrupla di numeri floating-point, ovvero la velocita', angolo, spostamento laterale e verticale
                            del velivolo al momento t_n,
                            un numero floating-point, il passo temporale.
        Dati in uscita:     una quadrupla di numeri floating-point, ovvero la velocita', angolo, spostamento laterale e verticale 
                            del velivolo al momento t_(n+1) -}
*/
metodo_eulero(V, THETA, X, Y, DT, V1, THETA1, X1, Y1) :-    rhs(V, THETA, VT, THETAT, XT, YT),
                                                            V1      is (V + (VT * DT)),
                                                            THETA1  is (THETA + (THETAT * DT)),
                                                            X1      is (X + (XT * DT)),
                                                            Y1      is (Y + (YT * DT)). 

/*  Predicato per l'applicazione dell'equazione del moto fugoide
        Dati in ingresso:   una coppia di numeri floating-point, ovvero la velocita' e l'angolo del velivolo.
        Dati in uscita:     una quadrupla di numeri floating-point, ovvero la velocita', angolo, spostamento laterale e verticale 
                            del velivolo dopo aver applicato l'equazione per il moto fugoide
*/
rhs(V, THETA, V1, THETA1, X1, Y1) :-  CG is 9.81,     /* Costante gravitazionale terrestre */
                                      CR is 0.025,    /* Coefficiente di resistenza all'aria */
                                      CP is 1.0,      /* Coefficiente di portanza */
                                      VTRIM is 30.0,  /* Velocita' di trim del velivolo */
                                      V1 is (- (CG * sin(THETA)) - (CR / CP) * CG/VTRIM**2*V**2),
                                      THETA1 is (- (CG * cos(THETA) / V) + (CG/VTRIM**2*V)),
                                      X1 is (V * cos(THETA)),
                                      Y1 is (V * sin(THETA)).  
