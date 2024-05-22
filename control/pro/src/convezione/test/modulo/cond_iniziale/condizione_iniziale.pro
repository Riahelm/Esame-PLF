
/* Il predicato cond_iniziale_conv calcola la condizione iniziale (una funzione)
   per il calcolo numerico dell'equazione di convezione:
   - il primo argomento è il numero di punti della griglia spaziale;
   - il secondo argomento è il limite inferiore del dominio spaziale;
   - il terzo argomento è il limite superiore del dominio spaziale; 
   - il quarto argomento è la funzione d'onda quadra. */


cond_iniziale_conv(NX,INF,SUP,ONDA) :- gen_punti_equi(NX,INF,SUP,L),
                                       onda_quadra(L,ONDA).


/**********************_INPUT_EXAMPLES_************************
   
   NX  = 41   -- numero di punti della griglia spaziale
   INF = 0.0  -- limite inferiore del dominio spaziale 
   SUP = 2.0  -- limite superiore del dominio spaziale

*_nota1: i parametri IN e SUP sono numeri reali; N deve essere 
intero: il controllo viene demandato al predicato gen_punti_equi

***************************************************************/


/* Il predicato onda_quadra calcola la funzione d'onda quadra:
   - il primo argomento è la lista di punti equidistanti del dominio
     spaziale;
   - il secondo argomento è la funzione d'onda calcolata. */

onda_quadra([],[]).
onda_quadra([X|L1],[OSI|T]) :- X >= 0.5, 
                               X =< 1.0,
                               OSI is 2.0,
                               onda_quadra(L1,T).
onda_quadra([X|L1],[OSI|T]) :- (X < 0.5; 
                               X > 1.0),
                               OSI is 1.0,
                               onda_quadra(L1,T).


/**********************_INPUT_EXAMPLES_************************

   OS = 2.0 -- valori assunti dalla parte alta della funzione
               d'onda quadra;
   OI = 1.0 -- valori assunti dalla parte bassa della funzione 
               d'onda quadra.

   --> OS = OI = OSI

***************************************************************/








