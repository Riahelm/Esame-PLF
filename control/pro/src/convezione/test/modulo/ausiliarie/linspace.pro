
/* Il predicato calc_punti_equi genera una lista di numeri equidistanti tra loro:
   - il primo argomento è il numero di punti che si vuole generare;
   - il secondo argomento è il limite inferiore della lista di punti;
   - il terzo argomento è il limite superiore della lista di punti;
   - il quarto argomento è la lista di punti equidistanti. */

gen_punti_equi(0,_,_,[]). 
gen_punti_equi(N,INF,SUP,L) :- N > 0,
                               DST is SUP - INF,
                               N1  is N - 1, 
                               calc_punti(0,N1,INF,DST,L).

calc_punti(N1,N1,INF,_,[INF]).
calc_punti(I,N1,INF,DST,[INF|L]) :- I < N1,
                                    I1   is I + 1,
                                    INF1 is INF + (DST/N1),
                                    calc_punti(I1,N1,INF1,DST,L).


/*************************_NOTE_AGGIUNTIVE_****************************

gen_punti_equi(N,INF,SUP,L) :- %- controlliamo che il numero si punti da generare
                               %- sia un intero naturale. -%
                               integer(N),
                               N >= 0,
                               %- calcoliamo la distanza tra il limite inferiore
			       %- e il limite superiore della lista di punti; i
                               %- limiti sono numeri reali.
                               DST is SUP - INF,
                               %- per generare il numero di punti richiesto occorre
			       %- decrementare di uno il numero di punti totale; 
                               %- *_nota1.
                               N1  is N - 1, 
                               %- predicato per generare la lista.
                               calc_punti(0,N1,INF,DST,L).

calc_punti(N1,N1,INF,_,[INF]).
calc_punti(I,N1,INF,DST,[INF|L]) :- I < N1,
                                    I1   is I + 1,
                                    INF1 is INF + (DST/N1),
                                    calc_punti(I1,N1,INF1,DST,L).

_nota1:
 -- se il numero di punti richiesto è 0 : false, I < N1, 0 < -1;
 -- se il numero di punti richiesto è 1 : true, [INF], I == N1, 0 == 0;
 -- se il numero di punti richiesto è >1: true, [INF|L], I < N1, 0 < N1.

***********************************************************************/

