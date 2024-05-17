
calcPuntiEqui(I,N,INF,SUP,L) :- integer(I),
                                I >= 0,
                                integer(N),
				N >= 0,
                                DST is SUP - INF,
                                N1  is N - 1, 
                                calcPunti(I,N1,INF,DST,L).

calcPunti(N1,N1,INF,_,[INF]).
calcPunti(I,N1,INF,DST,[INF|L]) :- I < N1,
                                   I1   is (I + 1),
                                   INF1 is (INF + (DST/N1)),
                                   calcPunti(I1,N1,INF1,DST,L).

/* Predicato per il conteggio degli elementi di una lista */
conta([],N,N).
conta([_|LX],N,I) :- I1 is N + 1,
                     conta(LX,I1,I).
