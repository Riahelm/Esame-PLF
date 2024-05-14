
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