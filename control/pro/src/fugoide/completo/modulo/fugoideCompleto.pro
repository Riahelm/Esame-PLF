
mainFugoideCompleto(DT, [Y0 | T]) :-    V0 is (30.0),
                                        THETA0 is (0.0),
                                        X0 is (0.0),
                                        Y0 is (1000.0),
                                        PASSI is (floor(100.0/DT)- 1),
                                        calcMoto(V0, THETA0, X0, Y0, DT, PASSI, T).

calcMoto(V, THETA, X, Y, DT, 0, [Y1])       :-  metodoEulero(V, THETA, X, Y, DT, _, _, _, Y1).  
calcMoto(V, THETA, X, Y, DT, LEN, [Y1 | T]) :-  LEN > 0,
                                                metodoEulero(V, THETA, X, Y, DT, V1, THETA1, X1, Y1),
                                                LEN1 is (LEN - 1),
                                                calcMoto(V1, THETA1, X1, Y1, DT, LEN1, T).


metodoEulero(V, THETA, X, Y, DT, V1, THETA1, X1, Y1) :- rhs(V, THETA, X, Y, VT, THETAT, XT, YT),
                                                        V1      is (V + (VT * DT)),
                                                        THETA1  is (THETA + (THETAT * DT)),
                                                        X1      is (X + (XT * DT)),
                                                        Y1      is (Y + (YT * DT)). 

rhs(V, THETA, X, Y, V1, THETA1, X1, Y1) :-  CG is (9.81),
                                            CR is (0.025),
                                            CP is (1.0),
                                            VTRIM is (30.0),
                                            V1 is (- (CG * sin(THETA)) - (CR / CP) * CG/VTRIM**2*V**2),
                                            THETA1 is (- (CG * cos(THETA) / V) + (CG/VTRIM**2*V)),
                                            X1 is (V * cos(THETA)),
                                            Y1 is (V * sin(THETA)).  
