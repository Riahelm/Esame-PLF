
/**************************__INPUT__***************************
   
   NX  = 41  -- numero di punti della griglia spaziale
   INF = 0.0 -- limite inferiore del dominio spaziale 
   SUP = 2.0 -- limite superiore del dominio spaziale
   I   = 0   -- indice su cui iterare

***************************************************************/

/* Predicato per il calcolo della condizione iniziale */
condizioneIniziale(I,X) :- NX   is 41,
                           INF is 0.0,
	                        SUP is 2.0,
			                  calcPuntiEqui(I,NX,INF,SUP,L),
                           calcOndaQuadra(L,X).

/* Predicato che genera un numero finito di punti tutti equidistanti 
   tra loro in un intervallo specificato */
calcPuntiEqui(N,N,INF,_,[INF]).   
calcPuntiEqui(I,N,INF,SUP,[INF|L]) :- I < N,
               	                    I1   is (I + 1),
                                      INF1 is (INF + (SUP / N)),
                                      calcPuntiEqui(I1,N,INF1,SUP,L).
                                    

/**************************__INPUT__***************************
   
   OS = 2.0 -- valori assunti dalla parte alta della funzione 
               d'onda quadra
   OI = 1.0 -- valori assunti dalla parte bassa della funzione 
               d'onda quadra
   L2 = ... -- funzione di onda quadra

   --> OS = OI = OSI
    
***************************************************************/

/* Predicato che definisce l'onda quadra */  
calcOndaQuadra([],[]).
calcOndaQuadra([X|L1],[OSI|T]) :- X >= (0.5), 
                                  X =< (1.0),
                                  OSI is (2.0),
                                  calcOndaQuadra(L1, T).
calcOndaQuadra([X|L1],[OSI|T]) :- (X < (0.5); 
                                  X > (1.0)),
                                  OSI is (1.0),
                                  calcOndaQuadra(L1, T).
                              


/**************************__INPUT__***************************
   LX = ...           -- condizione iniziale: funzione d'onda 
                         quadra
   I  = 0             -- indice su cui iterare
   C  = 1.0           -- velocità dell'onda 
   DT = 0.1           -- passo temporale (parametro in input)
   DX = SUP/ (N - 1)  -- distanza tra qualsiasi coppia di punti 
                         della griglia adiacenti 
   N1 = N - 1
   NT = 25            -- numero complessivo di passi temporali 
                         che deve effettuare l'algoritmo 

***************************************************************/
 
/**************************************************************
                              MAIN
***************************************************************/

/* Calcolo della funzione completa: predicato-main */
calculemus(I,F) :- NT  is 25,
                   NX   is 41,
                   C   is 1.0,
                   NX1  is NX - 1,
		             SUP is 2.0,
                   DT  is 0.02,
                   DX  is SUP / NX1,
                   condizioneIniziale(I,ONDA),
                   calcConvTempo(I,NT,NX1,C,DX,DT,ONDA,F).

/* Predicato per il calcolo integrae della funzione di convezione
   rispetto al tempo */         
calcConvTempo(NT,NT,_,_,_,_,F,F). 
calcConvTempo(I,NT,NX1,C,DX,DT,ONDA,F) :- I < NT,
                                          I1  is I + 1,
					                           estrai_elem(ONDA,X),                  /* restituisce il primo punto della funzione d'onda */
                                          calcConvSpazio(0,NX1,C,DX,DT,ONDA,Z), /* integra la funzione rispetto allo spazio */
					                           inserisci_elem(X,Z,R),                /* aggiunge la testa dell'onda al risultato dell'integrazione spaziale */
                                          calcConvTempo(I1,NT,NX1,C,DX,DT,R,F). /* calcola l'onda nel successivo passo spaziale */




 /* Predicato per il calcolo dell'integrale della funzione di convezione
    rispetto allo spazio */
 calcConvSpazio(NX1,NX1,_,_,_,_,[]). 
 calcConvSpazio(I,NX1,C,DX,DT,[E0|LX],[E|T]) :- I < NX1,
                                               estrai_elem(LX,E1),
	                                            passoEulero(E0,E1,DT,DX,C,RES),
 		                                         E  is RES, 			                                                   
					                                I1 is I + 1,
                                               calcConvSpazio(I1,NX1,C,DX,DT,LX,T).

 /* Predicato che effettua il passo di Eulero */
 passoEulero(E0,E1,DT,DX,C,RES) :- RES is E1 - C * (DT/DX) * (E1 - E0). 

/*******************************************************************
                       PREDICATI AUSILIARI
 *******************************************************************/
  
 /* Predicato che inserisce un elemento in testa alla lista */ 
 inserisci_elem(X, L, [X | L]).

 /* Predicato per estrarre il primo elemento di una lista */
 estrai_elem([X|_], X).  
 
                            



