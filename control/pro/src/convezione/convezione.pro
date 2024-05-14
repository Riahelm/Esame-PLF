
/* Funzione che genera un numero finito di punti tutti equidistanti tra loro in un intervallo specificato */

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
                              
                                                      

calc([],  _, []).
calc([X|L1], Y, [Y|T]) :- primo(X,Z),
                          Y is Z,
                          calc(L1, Z, T).

primo(2,0).
primo(3,1).


decidi([], _, []).
decidi([X|L1], O, [O|T]) :- X == 0,
                            O is 1,
			    decidi(L1, O, T).

decidi([X|L1], O, [O|T]) :- X == 1,
                            O is 0,
	  	            decidi(L1, O, T).
% NOTA: possibile accorpare più clausole aventi la stessa testa con ";".
                            



