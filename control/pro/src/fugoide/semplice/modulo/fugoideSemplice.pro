
mainFugoideSemplice(DT, [Z0 | T]) :-    Z0 is (100.0),
                                        B0 is (10.0),
                                        PASSI is (floor(100.0/DT)- 1),
                                        calcMoto(Z0, B0, DT, PASSI, T).

calcMoto(Y, V, DT, 0, [YT])       :-    metodoEulero(Y, V, DT, YT, _).  
calcMoto(Y, V, DT, LEN, [YT | T]) :-    LEN > 0,
                                        metodoEulero(Y, V, DT, YT, VT),
                                        LEN1 is (LEN - 1),
                                        calcMoto(YT, VT, DT, LEN1, T).


metodoEulero(Y, V, DT, Y1, V1):-    rhs(Y, V, YT, VT),
                                    Y1 is (Y + (YT * DT)),
                                    V1 is (V + (VT * DT)). 

rhs(Y, V, V, V1):-  CG is (9.81),
                    ZT is (100.0),
                    V1 is (CG * (1-Y/ZT)). 