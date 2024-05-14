
/* Funzione che genera un numero finito di punti tutti equidistanti tra loro in un intervallo specificato */




 condizioneIniziale(I,X) :- N   is 41,
                            INF is 0.0,
			    SUP is 2.0,
			    calcPuntiEqui(I, N, INF, SUP, L),
                            calcOndaQuadra(L, X).

/* input: 
   INF = 0.0  -- limite inferiore del dominio spaziale 
   SUP = 2.0  -- limite superiore del dominio spaziale
   I   = 0    -- indice su cui iterare
   N   = 41   -- numero di punti della funzione
*/


calcPuntiEqui(N, N, _, _, []).
calcPuntiEqui(I, N, INF, SUP, [INF | L]) :- I < N,
                                            I1   is (I + 1),
                                            INF1 is (INF + (SUP / N)),
                                            calcPuntiEqui(I1, N, INF1, SUP, L).
                                    

/* Funzione che definisce l'onda quadra */

/*input:
   OS = 2.0 -- valori assunti dalla parte alta della funzione d'onda quadra
   OI = 1.0 -- valori assunti dalla parte bassa della funzione d'onda quadra
   L2 = ... -- funzione di onda quadra

*/



   
calcOndaQuadra([], []).
calcOndaQuadra([X|L1], [OS | T]) :- X >= (0.5), 
                                    X =< (1.0),
                                    OS is (2.0),
                                    calcOndaQuadra(L1, T).
calcOndaQuadra([X|L1], [OS | T]) :- (X < (0.5); 
                                    X > (1.0)),
                                    OS is (1.0),
                                    calcOndaQuadra(L1, T).
                              


/*input:
   LX = ...          -- condizione iniziale: funzione d'onda quadra
   I  = 0            -- indice su cui iterare
   C  = 1.0          -- velocità dell'onda 
   DT = 0.1          -- passo temporale (parametro in input)
   DX = SUP/ (N - 1)  -- distanza tra qualsiasi coppia di punti della griglia adiacenti 
   N1 = N - 1

*/
 

 calculemus(I,X) :- C   is 1.0,
                    N   is 41,
		    N1  is N - 1,
		    SUP is 2.0,
		    DT  is 0.1,
		    DX  is SUP / N1,
		    condizioneIniziale(I,Y),
		    calcConvSpazio(I,N1,C,DX,DT,Y,X).
		      

 calcConvSpazio(N1,N1,C,DX,DT,[E0|_],[T])    :- passoEulero(E0,E0,DT,DX,C,T).
 calcConvSpazio(I,N1,C,DX,DT,[E0|LX],[E|T])  :- I < N1,
                                                estrai_elem(LX,E1),
	                                        passoEulero(E0,E1,DT,DX,C,RES),
						E  is RES,
					        I1 is I + 1,
                                                calcConvSpazio(I1,N1,C,DX,DT,LX,T).


 passoEulero(E0,E1,DT,DX,C,RES) :- RES is E0 - C * (DT/DX) * (E0 -  E1).        

 estrai_elem([X|LX], X).  
                            



