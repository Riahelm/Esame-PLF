
/**************************__INPUT__***************************
   
   NX  = 201      -- numero di punti della griglia spaziale
   INF = 0.0      -- limite inferiore del dominio spaziale 
   SUP = 2.0 * pi -- limite superiore del dominio spaziale
   I   = 0        -- indice su cui iterare

***************************************************************/

/* Predicato che genera un numero finito di punti tutti equidistanti 
   tra loro in un intervallo specificato */
condizioneIniziale(I,X) :- NX  is 201,   
                           INF is 0.0,
			               SUP is 2.0 * pi,
			               calcPuntiEqui(I, NX, INF, SUP, L),
                           calcOndaDenteSega(L, X).

/**************************__INPUT__***************************
   
   T0 = 0.0  -- tempo iniziale di simulazione
   NU = 0.07 -- coefficiente di diffusione
    
***************************************************************/

/* Predicato per il calcolo della derivata rispetto alla variabile x 
   della funzione phi */
phiprime(X,T0,NU,F) :- F is -(-8*T0 + 2*X)*exp(-(-4*T0 + X)^2/(4*NU*(T0 + 1)))/(4*NU*(T0 + 1)) 
                            exp(-(-4*T0 + X - 2*pi)^2/(4*NU*(T0 + 1)))/(4*NU*(T0 + 1)).   

/* Predicato per il calcolo della funzione phi */
phi(X,T0,NU,F) :- F is exp(-(X-4*T0)^2/(4*NU*(T0+1))) + exp(-(X-4*T0-2*pi)^2/(4*NU*(T0+1))).


/* Predicato per il calcolo dell'onda a dente di sega 'u' */
calcOndaDenteSega([],[]).
calcOndaDenteSega([X|LX],[U|LU]) :- T0 is 0.0,
                                    NU is 0.07,
                                    phiprime(X,T0,NU,F1),
                                    phi(X,T0,NU,F2),
                                    U is -2*NU*(F1 / F2)+4,
                                    calcOndaDenteSega(LX,LU)


