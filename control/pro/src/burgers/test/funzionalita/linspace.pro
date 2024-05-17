
calcPuntiEqui(I,N,INF,SUP,L) :- DST is SUP - INF,
                                calcPunti(I,N,INF,DST,L).

calcPunti(N,N,_,_,[]).
calcPunti(I,N,INF,DST,[INF|L]) :- I < N,
                                  I1   is (I + 1),
                                  INF1 is (INF + (DST / N)),
                                  calcPuntiEqui(I1,N,INF1,DST,L).