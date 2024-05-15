
/* Predicato che genera un numero finito di punti tutti equidistanti tra loro in un intervallo specificato */

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


calcPuntiEqui(N, N, INF,  _, [INF]).   
calcPuntiEqui(I, N, INF, SUP, [INF|L]) :- I < N,
               	                        I1   is (I + 1),
                                          INF1 is (INF + (SUP / N)),
                                          calcPuntiEqui(I1, N, INF1, SUP, L).
                                    

/* Predicato che definisce l'onda quadra */

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
   LX = ...           -- condizione iniziale: funzione d'onda quadra
   I  = 0             -- indice su cui iterare
   C  = 1.0           -- velocità dell'onda 
   DT = 0.1           -- passo temporale (parametro in input)
   DX = SUP/ (N - 1)  -- distanza tra qualsiasi coppia di punti della griglia adiacenti 
   N1 = N - 1
   NT = 25            -- numero complessivo di passi temporali che deve effettuare l'algoritmo 

*/
 
 /* test per il calcolo della convezione nello spazio */
 calculemus(I,X) :- C   is 1.0,
                    N   is 41,
		              N1  is N - 1,
		              SUP is 2.0,
		              DT  is 0.02,
		              DX  is SUP / N1,
		              condizioneIniziale(I,Y),
		              calcConvSpazio(I,N1,C,DX,DT,Y,X).


/* Calcolo della funzione completa: predicato-main */
calculemusDue(I,F) :- NT  is 25,
                      C   is 1.0,
                      N   is 41,
                      N1  is N - 1,
		                SUP is 2.0,
		                DT  is 0.02,
		                DX  is SUP / N1,
                      condizioneIniziale(I,ONDA),
                      calcConvTempo(I,N1,NT,C,DX,DT,ONDA,F).
	      
calcConvTempo(N, _,N, _, _, _, F,F). 
calcConvTempo(I,N1,NT,C,DX,DT,ONDA,F) :- I < NT,
                                         I1  is I + 1,
					                          estrai_elem(ONDA,X),                  % restituisce il primo punto della funzione d'onda
                                         calcConvSpazio(0,N1,C,DX,DT,ONDA,Z),  % integra la funzione rispetto allo spazio
					                          inserisci_elem(X,Z,R),                % aggiunge la testa dell'onda al risultato dell'integrazione spaziale
                                         calcConvTempo(I1,N1,NT,C,DX,DT,R,F).  % calcola l'onda nel successivo passo spaziale





 calcConvSpazio(N1,N1, _, _, _, _, []). 
 calcConvSpazio(I,N1,C,DX,DT,[E0|LX],[E|T]) :- I < N1,
                                               estrai_elem(LX,E1),
	                                            passoEulero(E0,E1,DT,DX,C,RES),
 		                                         E  is RES, 			                                                   
					       	                       I1 is I + 1,
                                               calcConvSpazio(I1,N1,C,DX,DT,LX,T).


 passoEulero(E0,E1,DT,DX,C,RES) :- RES is E1 - C * (DT/DX) * (E1 - E0).   

 inserisci_elem(X, L, [X | L]).
 estrai_elem([X|_], X).  
 
                            



