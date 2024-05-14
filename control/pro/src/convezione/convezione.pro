
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

calcOndaQuadra([], OS, []).
calcOndaQuadra([X|L1],OS,[OS|T]) :- %OS is 2.0,
                                     X >= (0.5),
                                     X =< (1.0),
                                     calcOndaQuadra(L1, OS, T).

/*calcOndaQuadra([X|L1], [Y|L2]) :- OI is 1.0,
                                  X < (0.5),
                                  X > (1.0),
                                  calcOndaQuadra(L1, [OI|L2]).
*/
% NOTA: possibile accorpare più clausole aventi la stessa testa con ";".
                            



