
/* Il predicato cond_iniziale calcola la condizione iniziale (una funzione)
   per il calcolo numerico dell'equazione di Burgers:
   - il primo argomento è il numero di punti della griglia spaziale;
   - il secondo argomento è il limite inferiore del dominio spaziale;
   - il terzo argomento è il limite superiore del dominio spaziale; 
   - il quarto argomento è la funzione "onda a dente di sega". */

cond_iniziale(NX,INF,SUP,ONDA) :- gen_punti_equi(NX,INF,SUP,L),
                                  onda_dente_sega(L,ONDA).


/**********************_INPUT_EXAMPLES_************************
   
   NX  = 201      -- numero di punti della griglia spaziale
   INF = 0.0      -- limite inferiore del dominio spaziale 
   SUP = 2.0 * pi -- limite superiore del dominio spaziale

***************************************************************/


/* Il predicato calcola la funzione d'onda a dente di sega 'u':
   - il primo argomento è la lista di punti equidistanti del dominio
     spaziale;
   - il secondo argomento è la funzione d'onda calcolata. 
   Per il calcolo dell'onda si fa uso dei predicati phi e phi_primo 
   che sono rispettavamente una funzione e la sua derivata. */

onda_dente_sega([],[]).
onda_dente_sega([X|LX],[U|LU]) :- T0 is 0.0,
                                  NU is 0.07,
                                  phi_primo(X,T0,NU,F1),
                                  phi(X,T0,NU,F2),
                                  U is -2*NU*(F1 / F2)+4,
                                  onda_dente_sega(LX,LU).

phi_primo(X,T0,NU,F) :- F is -(-8*T0 + 2*X)*exp(-((-4*T0 + X)^2)/(4*NU*(T0 + 1)))/(4*NU*(T0 + 1)) - (-8*T0 + 
                            2*X - 4*pi)*exp(-((-4*T0 + X - 2*pi)^2)/(4*NU*(T0 + 1)))/(4*NU*(T0 + 1)).   

phi(X,T0,NU,F) :- F is exp(-((X-4*T0)^2)/(4*NU*(T0+1))) + exp(-((X-4*T0-2*pi)^2)/(4*NU*(T0+1))).



/**********************_INPUT_EXAMPLES_************************
   
   T0 = 0.0  -- tempo iniziale di simulazione
   NU = 0.07 -- coefficiente di diffusione

***************************************************************/








