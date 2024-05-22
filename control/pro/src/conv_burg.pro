

/* Predicato MAIN */
calc_burgers(NX,F) :- NX1 is NX - 1,
                      T   is 0.6,
                      S   is 0.1,
                      NU  is 0.07,
                      INF is 0.0,
                      SUP is 2.0 * pi,
                      DX  is SUP / NX1,
                      DT  is S * DX^2 / NU,
                      NT  is floor(T/DT),
                      cond_iniziale_burg(NX,INF,SUP,ONDA),
                      tempo_burg(0,NT,NX1,NU,DX,DT,ONDA,F).

/* Il predicato calc_convezione calcola l'integrazione numerica
   dell'equazione di convezione lineare a una dimensione.*/
calc_convezione(NX,_,F)  :- (NX == 0;
                            NX == 1),
                            INF is 0.0,
                            SUP is 2.0,
                            cond_iniziale_conv(NX,INF,SUP,F).
calc_convezione(NX,DT,F) :- NX > 1,
                            NT  is 25,
                            NX1 is NX - 1,
                            C   is 1.0,
                            INF is 0.0,
                            SUP is 2.0,
                            DX  is SUP / NX1,
                            cond_iniziale_conv(NX,INF,SUP,ONDA),
                            tempo_conv(0,NT,NX1,C,DX,DT,ONDA,F).


/* Il predicato tempo_burg calcola numericamente l'integrale della
   funzione rispetto al parametro temporale DT:
   - il primo termine e' il numero di passi temporali che la funzione
     d'onda ha compiuto;
   - il secondo termine e' il numero di passi temporali totali che la
     funzione d'onda deve compiere; 
   - il terzo termine e' il numero di passi spaziali utilizzati dal
     predicato conv_spazio;
   - il quarto termine e' il coefficiente di diffusione;         
   - il quinto termine e' la lunghezza del passo spaziale;
   - il sesto termine e' la lunghezza del passo temporale;
   - il settimo termine e' la funzione d'onda ricalcolata;
   - l' ottavo termine e' la funzione d'onda risultante. */

tempo_burg(NT,NT,_,_,_,_,F,F).
tempo_burg(I,NT,NX1,NU,DX,DT,ONDA,F) :- I < NT,
                                        I1  is I + 1,
                                        bordo_inf(ONDA,NU,DX,DT,BI),
                                        spazio_burg(1,NX1,NU,DX,DT,ONDA,Z),
                                        inserisci_elem(BI,Z,R),
                                        tempo_burg(I1,NT,NX1,NU,DX,DT,R,F).


/* Il predicato spazio_burg calcola numericamente l'integrale della
   funzione rispetto al parametro spaziale DX:
   - il primo termine e' l'indice per accedere agli elementi della 
     lista, viene utlizzato da passo_eulero; 
   - il secondo termine e' il numero di punti della funzione; 
   - il terzo termine e' il coefficiente di diffusione;  
   - il quarto termine e' la lunghezza del passo spaziale;
   - il quinto termine e' la lunghezza del passo temporale;
   - il sesto termine e' la funzione d'onda;
   - il settimo termine e' la funzione d'onda ricalcolata con il passo_
     eulero e bordo_sup. */

spazio_burg(NX1,NX1,NU,DX,DT,ONDA,[F]) :- bordo_sup(ONDA,NU,DX,DT,F).
spazio_burg(I,NX1,NU,DX,DT,ONDA,[E|F]) :- I < NX1,
                                          I1 is I + 1,
                                          passo_eulero_burg(ONDA,I,NU,DX,DT,E),
                                          spazio_burg(I1,NX1,NU,DX,DT,ONDA,F).


/* Il predicato bordo_inf calcola le condizioni di bordo inferiore della funzione:
   - il primo termine e' la funzione d'onda;
   - il secondo termine e' il coefficiente di diffusione;
   - il terzo termine e' la lunghezza del passo spaziale;
   - il quarto termine e' la lunghezza del passo temporale;
   - il quinto termine e' il valore del punto estremo inferiore della funzione.
   L'uso di last e testa consente di selezionare gli elementi in coda e in testa
   alla funzione per il calcolo della condizione */
   
bordo_inf([X|LX],NU,DX,DT,BI) :- last(LX,C),
                                 testa(LX,T),
                                 BI is X - X*DT/DX * (X - C) + NU*DT/DX^2 * (T - 2*X + C).

/* Il predicato bordo_sup calcola le condizioni di bordo superiore della funzione:
   - il primo termine e' la funzione d'onda;
   - il secondo termine e' il coefficiente di diffusione;
   - il terzo termine e' la lunghezza del passo spaziale;
   - il quarto termine e' la lunghezza del passo temporale;
   - il quinto termine e' il valore del punto estremo superiore della funzione.
   L'uso di last, testa e penultimo consente di selezionare l'ultimo, il primo e
   il penultimo elemento della funzione per il calcolo della condizione */

bordo_sup(ONDA,NU,DX,DT,BS) :- last(ONDA,C),
                               penultimo(ONDA,P),
                               testa(ONDA,T),
                               BS is C - C*DT/DX * (C - P) + NU*DT/DX^2 * (T - 2*C + P).

/* Il predicato passo_eulero effettua il passo di Eulero:
   - il primo termine e' la funzione d'onda;
   - il secondo termine e' l'indice dell'elemento corrente della lista;
   - il terzo termine e' il coefficiente di diffusione;
   - il quarto termine e' la lunghezza del passo spaziale;
   - il quinto termine e' la lunghezza del passo temporale;
   - il sesto termine e' il valore risultante del punto applicato il passo di eulero.
   L'uso del predicato nth consente di accedere agli elementi della lista tramite
   indice. Gli elementi sono indicizzati da 1 a N. */

passo_eulero_burg(ONDA,I0,NU,DX,DT,EU) :- I1 is I0 + 1,
                                          I2 is I1 + 1,
                                          nth(I0,ONDA,E0),
                                          nth(I1,ONDA,E1),
                                          nth(I2,ONDA,E2),
                                          EU is E1 - E1*DT/DX * (E1 - E0) + NU*DT/DX^2 * (E2 - 2*E1 + E0).


/* Il predicato cond_iniziale_burg calcola la condizione iniziale (una 
   funzione) per il calcolo numerico dell'equazione di Burgers:
   - il primo argomento e' il numero di punti della griglia spaziale;
   - il secondo argomento e' il limite inferiore del dominio spaziale;
   - il terzo argomento e' il limite superiore del dominio spaziale; 
   - il quarto argomento e' la funzione "onda a dente di sega". */

cond_iniziale_burg(NX,INF,SUP,ONDA) :- gen_punti_equi(NX,INF,SUP,L),
                                       onda_dente_sega(L,ONDA).


/* Il predicato onda_dente_sega calcola la funzione d'onda a dente di 
    sega 'u':
   - il primo argomento e' la lista di punti equidistanti del dominio
     spaziale;
   - il secondo argomento e' la funzione d'onda calcolata. 
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


/* Il predicato tempo_conv calcola numericamente l'integrale della
   funzione rispetto al parametro temporale DT:
   - il primo termine e' il numero di passi temporali che la funzione
     d'onda ha compiuto;
   - il secondo termine e' il numero di passi temporali totali che la
     funzione d'onda deve compiere; 
   - il terzo termine e' il numero di passi spaziali utilizzati dal
     predicato conv_spazio;
   - il quarto termine e' la costante di velocità dell'onda;     
   - il quinto termine e' la lunghezza del passo spaziale;
   - il sesto termine e' la lunghezza del passo temporale;
   - il settimo termine e' la funzione d'onda ricalcolata;
   - l' ottavo termine e' la funzione d'onda risultante. */

tempo_conv(NT,NT,_,_,_,_,F,F).
tempo_conv(I,NT,NX1,C,DX,DT,ONDA,F) :- I < NT,
                                       I1  is I + 1,
                                       testa(ONDA,T),                
                                       spazio_conv(0,NX1,C,DX,DT,ONDA,F1), 
                                       inserisci_elem(T,F1,R),                
                                       tempo_conv(I1,NT,NX1,C,DX,DT,R,F). 


/* Il predicato spazio_conv calcola numericamente l'integrale della
   funzione rispetto al parametro spaziale DX:
   - il primo termine e' il numero di passi temporali che la funzione
     d'onda ha compiuto;
   - il secondo termine e' il numero di passi temporali totali che la
     funzione d'onda deve compiere; 
   - il terzo termine e' la costante di velocità dell'onda;      
   - il quarto termine e' la lunghezza del passo spaziale;
   - il quinto termine e' la lunghezza del passo temporale;
   - il sesto termine e' la funzione d'onda;
   - il settimo termine e' la funzione d'onda ricalcolata con passo_
     eulero_conv */

spazio_conv(NX1,NX1,_,_,_,_,[]).
spazio_conv(I,NX1,C,DX,DT,[E0|LX],[E|T]) :- I < NX1,
                                            I1 is I + 1,
                                            testa(LX,E1),
                                            passo_eulero_conv(E0,E1,C,DX,DT,EU),
                                            E  is EU,
                                            spazio_conv(I1,NX1,C,DX,DT,LX,T).


/* Il predicato passo_eulero_conv effettua il passo di Eulero:
   - il primo termine e' l'elemento corrente della lista;
   - il secondo termine e' l'elemento successivo a quello corrente della lista;
   - il terzo termine e' la costante di velocità dell'onda;
   - il quarto termine e' la lunghezza del passo spaziale;
   - il quinto termine e' la lunghezza del passo temporale;
   - il sesto termine e' il valore risultante del punto applicato il passo di eulero.
*/

passo_eulero_conv(E0,E1,C,DX,DT,EU) :- EU is E1 - C * (DT/DX) * (E1 - E0).


/* Il predicato cond_iniziale_conv calcola la condizione iniziale (una funzione)
   per l'integrazione numerica dell'equazione di convezione:
   - il primo argomento e' il numero di punti della griglia spaziale;
   - il secondo argomento e' il limite inferiore del dominio spaziale;
   - il terzo argomento e' il limite superiore del dominio spaziale; 
   - il quarto argomento e' la funzione d'onda quadra. */

cond_iniziale_conv(NX,INF,SUP,ONDA) :- gen_punti_equi(NX,INF,SUP,L),
                                       onda_quadra(L,ONDA).


/* Il predicato onda_quadra calcola la funzione d'onda quadra:
   - il primo argomento e' la lista di punti equidistanti del dominio
     spaziale;
   - il secondo argomento e' la funzione d'onda calcolata. */

onda_quadra([],[]).
onda_quadra([X|L1],[OSI|T]) :- X >= 0.5,
                               X =< 1.0,
                               OSI is 2.0,
                               onda_quadra(L1,T).
onda_quadra([X|L1],[OSI|T]) :- (X < 0.5; 
                               X > 1.0),
                               OSI is 1.0,
                               onda_quadra(L1,T).



/* Il predicato gen_punti_equi genera una lista di punti equidistanti tra loro:
   - il primo argomento e' il numero di punti che si vuole generare;
   - il secondo argomento e' il limite inferiore della lista di punti;
   - il terzo argomento e' il limite superiore della lista di punti;
   - il quarto argomento e' la lista di punti equidistanti. 
   Per il calcolo dei punti si fa uso del predicato calc_punti.*/

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

/* funzioni ausiliarie */
 
/* Predicato che inserisce un elemento in testa alla lista */
 inserisci_elem(X, L, [X | L]).

/* Predicato che estrae la lista di elementi successivi al primo */
estrai_lista([_|LX],LX).

/* Predicato per estrarre il primo elemento di una lista */
testa([X|_], X).

/* Predicato che restituisce il penultimo elemento di una lista */
penultimo(LX,X) :- reverse(LX,LXInv),
                   estrai_lista(LXInv,Y),
                   testa(Y,X).

/* Predicato per aggiungere un elemento alla fine di una lista */
accoda_elem(X, [], [X]).
accoda_elem(X, [Y | L], [Y | LX]) :- accoda_elem(X, L, LX).



