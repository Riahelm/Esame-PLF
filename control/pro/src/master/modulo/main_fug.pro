
main :-
    nl,
    write('Progetto della sessione estiva del corso Programmazione Logica e Funzionale'), nl,
    write('Anno 2023/2024'), nl,
    write('Corso tenuto dal prof. Marco Bernardo'), nl,
    write('Progetto realizzato da: Barzotti Nicolas e Ramagnano Gabriele'), nl, nl, nl,

    write('Calcolo del moto di fugoide senza attrito'), nl,
    write('Digita la lunghezza del passo temporale: '), nl,
    read(DT),
    main_fugoide_semplice(DT, FS),
    write(FS),

    write('Calcolo del moto di fugoide con attrito'), nl, 
    write('Digita la lunghezza del passo temporale: '), nl,
    read(DT),
    main_fugoide_completo(DT, FC),
    write(FC).

    /*write('Calcolo della equazione di convezione lineare a una dimensione'),
    write('Digita il numero di punti totali della funzione di onda: '),
    read(NX),
    write('Digita la lunghezza del passo temporale della funzione di onda: '),
    read(DT),
    main_convezione(DT, NX, CONV),
    write(CONV),

    write('Calcolo della equazione di Burgers a una dimensione'),
    write('Digita il numero di punti totali della funzione di onda: '),
    read(NX),
    main_burgers(NX, BURG),
    write(BURG),*/

main_fugoide_semplice(DT, [Z0 | T]) :-  Z0 is 100.0,
                                        B0 is 10.0,
                                        PASSI is (floor(100.0/DT)- 1),
                                        calc_moto(Z0, B0, DT, PASSI, T).


calc_moto(Y, V, DT, 0, [YT])       :-   metodo_eulero(Y, V, DT, YT, _).  
calc_moto(Y, V, DT, LEN, [YT | T]) :-   LEN > 0,
                                        metodo_eulero(Y, V, DT, YT, VT),
                                        LEN1 is (LEN - 1),
                                        calc_moto(YT, VT, DT, LEN1, T).


metodo_eulero(Y, V, DT, Y1, V1) :-  rhs(Y, V, YT, VT),
                                    Y1 is (Y + (YT * DT)),
                                    V1 is (V + (VT * DT)). 

rhs(Y, V, V, V1) :- CG is 9.81,
                    ZT is 100.0,
                    V1 is CG * (1-Y/ZT). 

main_fugoide_completo(DT, [Y0 | T]) :-  V0 is 30.0,
                                        THETA0 is 0.0,
                                        X0 is 0.0,
                                        Y0 is 1000.0,
                                        PASSI is (floor(100.0/DT)- 1),
                                        calc_moto(V0, THETA0, X0, Y0, DT, PASSI, T).

calc_moto(V, THETA, X, Y, DT, 0, [Y1])       :-  metodo_eulero(V, THETA, X, Y, DT, _, _, _, Y1).  
calc_moto(V, THETA, X, Y, DT, LEN, [Y1 | T]) :-  LEN > 0,
                                                metodo_eulero(V, THETA, X, Y, DT, V1, THETA1, X1, Y1),
                                                LEN1 is (LEN - 1),
                                                calc_moto(V1, THETA1, X1, Y1, DT, LEN1, T).


metodo_eulero(V, THETA, X, Y, DT, V1, THETA1, X1, Y1) :-    rhs(V, THETA, X, Y, VT, THETAT, XT, YT),
                                                            V1      is (V + (VT * DT)),
                                                            THETA1  is (THETA + (THETAT * DT)),
                                                            X1      is (X + (XT * DT)),
                                                            Y1      is (Y + (YT * DT)). 

rhs(V, THETA, _, _, V1, THETA1, X1, Y1) :-  CG is 9.81,
                                            CR is 0.025,
                                            CP is 1.0,
                                            VTRIM is 30.0,
                                            V1 is (- (CG * sin(THETA)) - (CR / CP) * CG/VTRIM**2*V**2),
                                            THETA1 is (- (CG * cos(THETA) / V) + (CG/VTRIM**2*V)),
                                            X1 is (V * cos(THETA)),
                                            Y1 is (V * sin(THETA)).  
