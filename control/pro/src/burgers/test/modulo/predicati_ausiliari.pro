
/*******************************************************************
                       PREDICATI AUSILIARI
 *******************************************************************/

 /* Predicato che inserisce un elemento in testa alla lista */ 
 inserisci_elem(X, L, [X | L]).

/* Predicato che estrae un elemento da una lista dato un indice */
 estrai(N,N,[X|_],X).
 estrai(I,N,[_|LX],Z) :- I < N,
                         I1 is I + 1,
			             estrai(I1,N,LX,Z).

/* Predicato che restituisce  la coda di una lista */ 
coda(LX,X) :- inverti(LX,Y),
              estrai_elem(Y,X).

/* Predicato che restituisce il penultimo elemento di una lista */
penultimo(LX,X) :- inverti(LX,LXInv),
                   estrai_lista(LXInv,Y),
                   estrai_elem(Y,X).
                  
/* Predicato che estrae la lista di elementi successivi al primo */
estrai_lista([_|LX],LX). 

/* Predicato per estrarre il primo elemento di una lista */
estrai_elem([X|_], X).

/* Predicato per aggiungere un elemento alla fine di una lista */
accoda_elem(X, [], [X]).
accoda_elem(X, [Y | L], [Y | LX]) :- accoda_elem(X, L, LX).

/* Predicato per invertire l’ordine degli elementi di una lista */
inverti([], []).
inverti([X | L1], L2) :- inverti(L1, L1Inv), 
                         accoda_elem(X, L1Inv, L2).

/* Predicato per il conteggio degli elementi di una lista */
conta([],N,N).
conta([_|LX],N,I) :- I1 is N + 1,
                     conta(LX,I1,I).
