
/* Funzione che genera un numero finito di punti tutti equidistanti tra loro in un intervallo specificato */

/* input: 
   INF = 0.0  -- limite inferiore del dominio spaziale 
   SUP = 2.0  -- limite superiore del dominio spaziale
   I   = 0    -- indice su cui iterare
   N   = 41   -- numero di punti della funzione
*/


calcPuntiEqui(N, N, _, _,[]).
calcPuntiEqui(I, N, INF, SUP, [INF | L]) :- I < N,
	                                    I1   is (I + 1),
                                            INF1 is (INF + (SUP / N)),
                                            calcPuntiEqui(I1, N, INF1, SUP, L).


