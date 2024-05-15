
/**************************__INPUT__***************************
   
   NX  = 201      -- numero di punti della griglia spaziale
   INF = 0.0      -- limite inferiore del dominio spaziale 
   SUP = 2.0 * pi -- limite superiore del dominio spaziale
   I   = 0        -- indice su cui iterare

***************************************************************/

/* Predicato per il calcolo della condizione iniziale */
condizioneIniziale(I,X) :- NX  is 201,   
                           INF is 0.0,
			                  SUP is 2.0 * pi,
			                  calcPuntiEqui(I, NX, INF, SUP, L),
                           calcOndaDenteSega(L, X).

/* Predicato che genera un numero finito di punti tutti equidistanti 
   tra loro in un intervallo specificato */
calcPuntiEqui(N, N, _, _, []).
calcPuntiEqui(I, N, INF, SUP, [INF | L]) :- I < N,
                                            I1   is (I + 1),
                                            INF1 is (INF + (SUP / N)),
                                            calcPuntiEqui(I1, N, INF1, SUP, L).

/**************************__INPUT__***************************
   
   T0 = 0.0  -- tempo iniziale di simulazione
   NU = 0.07 -- coefficiente di diffusione
    
***************************************************************/

/* Predicato per il calcolo della derivata rispetto alla variabile x 
   della funzione phi */
phiprime(X,T0,NU,F) :- F is -(-8*T0 + 2*X)*exp(-((-4*T0 + X)^2)/(4*NU*(T0 + 1)))/(4*NU*(T0 + 1)) - (-8*T0 + 
                            2*X - 4*pi)*exp(-((-4*T0 + X - 2*pi)^2)/(4*NU*(T0 + 1)))/(4*NU*(T0 + 1)).   

/* Predicato per il calcolo della funzione phi */
phi(X,T0,NU,F) :- F is exp(-((X-4*T0)^2)/(4*NU*(T0+1))) + exp(-((X-4*T0-2*pi)^2)/(4*NU*(T0+1))).


/* Predicato per il calcolo dell'onda a dente di sega 'u' */
calcOndaDenteSega([],[]).
calcOndaDenteSega([X|LX],[U|LU]) :- T0 is 0.0,
                                    NU is 0.07,
                                    phiprime(X,T0,NU,F1),
                                    phi(X,T0,NU,F2),
                                    U is -2*NU*(F1 / F2)+4,
                                    calcOndaDenteSega(LX,LU).

/**************************__INPUT__***************************
   
   DX = SUP / (NX - 1)   -- distanza tra qualsiasi coppia di punti della griglia adiacenti
   S  = 0.1              -- costante di Courant-Friedrichs_Lewy (CFL) - sigma -
   DT = S * DX^2 / NU    -- lunghezza del passo temporale
   T  = 0.6              -- tempo totale di simulazione 
   NT = truncate(T / DT) -- numero complessivo di passi temporali che deve effettuare l'algoritmo 
     
***************************************************************/

/**************************************************************
                              MAIN
***************************************************************/

/* Predicato MAIN */
calculemus(I,F) :- NX  is 201,
                   T   is 0.6,
                   S   is 0.1,
                   NU  is 0.07,
                   SUP is 2.0 * pi,
                   DX  is SUP / (NX - 1),
                   DT  is S * DX^2 / NU,
                   NT  is truncate(T / DT),
                   condizioneIniziale(I,ONDA),
                   calcConvTempo(I,NT,NX,NU,DX,DT,ONDA,F).
                      

/* Predicato per il calcolo integrae della funzione di Burgers
   rispetto al tempo */
calcConvTempo(NT, NT, _, _, _, _, F,F). 
calcConvTempo(I, NT, NX, NU, DX, DT, ONDA, F) :- I < NT,
                                                 I1  is I + 1,
					                             condBordoInf(ONDA,NU,DX,DT,BI),                    
                                                 calcConvSpazio(0,NX,NU,DX,DT,ONDA,ONDA,Z),  
					                             inserisci_elem(BI,Z,R),                
                                                 calcConvTempo(I1,NX,NT,NU,DX,DT,R,F).

/* Predicato per il calcolo dell'integrale della funzione di Burgers 
   rispetto allo spazio */
calcConvSpazio(NX, NX, NU, DX, DT, _, ONDA, [F])    :- condBordoSup(NU,DX,DT,ONDA,F).
calcConvSpazio(I, NX, NU, DX, DT, [X|LX], _, [E|F]) :- I < NX,
                                                       I1 is I + 1,
                                                       passoEulero(X,NU,DX,DT,LX,EU),
                                                       E is EU,
                                                       calcConvSpazio(I1,NX,NU,DX,DT,LX,_,F).

/* Predicato per il calcolo delle condizioni di bordo inferiore */
condBordoInf([X|LX],NU,DX,DT,BI) :- coda(LX,C),
                                    estrai_elem(LX,T),
                                    BI is X - X*DT/DX * (X - C) + NU*DT/DX^2 * (T - 2*X + C).

/* Predicato per il calcolo delle condizioni di bordo superiore */
condBordoSup(NU,DX,DT,ONDA,BS) :- coda(ONDA,C),
                                  penultimo(ONDA,P),
                                  estrai_elem(ONDA,T),
                                  BS is C - C*DT/DX * (C - P) + NU*DT/DX^2 * (T - 2*C) + P. 

/* Predicato che effettua il passo di Eulero */
passoEulero(E0,NU,DX,DT,[E1|LY],EU) :- estrai_elem(LY,E2),
                                       EU is E1 - E1*DT/DX * (E1 - E0) + NU*DT/DX^2 * (E2 - 2*E1 + E0).


/*******************************************************************
                       PREDICATI AUSILIARI
 *******************************************************************/

/* Predicato che restituisce  la coda di una lista */ 
coda(LX,X) :- inverti(LX,Y),
              estrai_elem(Y,X).

/* Predicato che restituisce il penultimo elemento di una lista */
punultimo(LX,X) :- inverti(LX,LXInv),
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
inverti([X | L1], L2) :- inverti(L1, L1Inv), accoda_elem(X, L1Inv, L2).


