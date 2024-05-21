
main :-
    nl,
    write('Progetto della sessione estiva del corso Programmazione Logica e Funzionale'), nl,
    write('Anno 2023/2024'),                                                              nl,
    write('Corso tenuto dal prof. Marco Bernardo'),                                       nl,
    write('Progetto realizzato da: Barzotti Nicolas e Ramagnano Gabriele'),               nl,  
    nl, 
    nl,
    write('Calcolo del moto di fugoide senza attrito'),   	                          nl,
    write('Digita la lunghezza del passo temporale: '),                                   nl,
    read(DT),
    main_fugoide_semplice(DT, FS),
    write(FS),
    nl,
    write('Calcolo del moto di fugoide con attrito'),                                     nl, 
    write('Digita la lunghezza del passo temporale: '),                                   nl,
    read(DT2),
    main_fugoide_completo(DT2, FC),
    write(FC),                                           
    nl,
    write('Calcolo della equazione di convezione lineare a una dimensione'),              nl,
    write('Digita il numero di punti totali della funzione di onda: '),                  
    /* Il dato deve essere:
       - una variaile istanziata,
       - un intero positivo maggiore di zero. */
    read(NXCV),
    valida(NXCV,
           'Digita il numero di punti totali della funzione di onda: ',
           NXC),                                                                          nl,
    write('Digita la lunghezza del passo temporale: '),                                   nl,
    read(DT3),
    calc_convezione(NXC,DT3,CONV),
    write(CONV),
    nl,
    write('Calcolo della equazione di Burgers a una dimensione'),                         nl,
    write('Digita il numero di punti totali della funzione di onda: '),  
    read(NXBV),
    valida(NXBV,
           'Digita il numero di punti totali della funzione di onda: ',
           NXB),                                                                          nl,    
    calc_burgers(NXB,BURG),      
    write(BURG).


    valida(NXV,MSG,NX) :- integer(NXV),
                          NXV > 0,
                          write('valore accettato'),
                     	  NX is NXV,
                          !;
                          write('inserimento errato!'), nl,
                          write(MSG), 
                          read(V),
                          valida(V,MSG,NX).
                   


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
                                        PASSI is (floor(100.0/DT)- 1),  /* Numero di punti in cui effettuare il calcolo */
                                        calc_moto(V0, THETA0, X0, Y0, DT, PASSI, T). 

/*  Predicato per il calcolo numerico dell'integrazione del moto fugoide 
        Dati in ingresso:   una quadrupla di numeri floating-point, questi sono velocita', angolo, spostamento laterale e verticale del velivolo,
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
                            del velivolo al momento t_(n+1) 
*/
metodo_eulero(V, THETA, X, Y, DT, V1, THETA1, X1, Y1) :-    rhs(V, THETA, X, Y, VT, THETAT, XT, YT),
                                                            V1      is (V + (VT * DT)),
                                                            THETA1  is (THETA + (THETAT * DT)),
                                                            X1      is (X + (XT * DT)),
                                                            Y1      is (Y + (YT * DT)). 

/*  Predicato per l'applicazione dell'equazione del moto fugoide
        Dati in ingresso:   una quadrupla di numeri floating-point, ovvero la velocita', angolo, spostamento laterale e verticale 
                            del velivolo.
        Dati in uscita:     una quadrupla di numeri floating-point, ovvero la velocita', angolo, spostamento laterale e verticale 
                            del velivolo dopo aver applicato l'equazione per il moto fugoide
*/
rhs(V, THETA, _, _, V1, THETA1, X1, Y1) :-  CG is 9.81,     /* Costante gravitazionale terrestre */
                                            CR is 0.025,    /* Coefficiente di resistenza all'aria */
                                            CP is 1.0,      /* Coefficiente di portanza */
                                            VTRIM is 30.0,  /* Velocita' di trim del velivolo */
                                            V1 is (- (CG * sin(THETA)) - (CR / CP) * CG/VTRIM**2*V**2),
                                            THETA1 is (- (CG * cos(THETA) / V) + (CG/VTRIM**2*V)),
                                            X1 is (V * cos(THETA)),
                                            Y1 is (V * sin(THETA)).  
