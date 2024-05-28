
/* Programma Prolog per effettuare simulazioni numeriche */

main :-
    write('Progetto della sessione estiva del corso Programmazione Logica e Funzionale'), nl,
    write('Anno 2023/2024'), nl,
    write('Corso tenuto dal prof. Marco Bernardo'), nl,
    write('Progetto realizzato da: Barzotti Nicolas e Ramagnano Gabriele'), nl,

    write('--------------------------------------------------------------------'), nl,
    write('| Calcolo del moto fugoide senza attrito                           |'), nl,
    write('| Parametri iniziali:                                              |'), nl,
    write('| altitudine iniziale        = 100m,                               |'), nl,
    write('| velocita\' iniziale         = 10m/s.                              |'), nl,
    write('| Parametri di simulazione:                                        |'), nl,
    write('| secondi di simulazione     = 100s,                               |'), nl,
    write('| costante gravitazionale    = 9.81m/(s^2).                        |'), nl,
    write('| Parametro richiesto:                                             |'), nl,
    write('| passo temporale, determina la distanza temporale                 |'), nl,
    write('| tra due punti di simulazione, un valore basso                    |'), nl,
    write('| permette una simulazione piu\' accurata.                          |'), nl,
    write('| Il valore del passo temporale deve essere maggiore di zero.      |'), nl,
    write('--------------------------------------------------------------------'), nl,

    acquisisci_dato_dt(DT),                                                        
    calc_fugoide_semplice(DT, FS),
    write(FS),                                                                     nl,

    write('--------------------------------------------------------------------'), nl,
    write('| Calcolo del moto fugoide con attrito                             |'), nl,
    write('| Parametri iniziali:                                              |'), nl,
    write('| velocita\' iniziale                    = velocita\' di trim,       |'), nl,
    write('| angolo iniziale                       = 0rad,                    |'), nl,
    write('| spostamento laterale iniziale         = 0m,                      |'), nl,
    write('| spostamento verticale iniziale        = 1000m.                   |'), nl,
    write('| Parametri di simulazione:                                        |'), nl,
    write('| secondi di simulazione                = 100s,                    |'), nl,
    write('| velocita\' di trim                     = 30m/s,                   |'), nl,
    write('| costante gravitazionale               = 9.81m/(s^2),             |'), nl,
    write('| coefficiente di resistenza dell\'aria  = 0.025,                   |'), nl,
    write('| coefficiente di portanza              = 1N.                      |'), nl,
    write('| Parametro richiesto:                                             |'), nl,
    write('| passo temporale, determina la distanza temporale                 |'), nl,
    write('| tra due punti di simulazione, un valore basso                    |'), nl,
    write('| permette una simulazione piu\' accurata.                          |'), nl,
    write('| Il valore del passo temporale deve essere maggiore di zero.      |'), nl,
    write('--------------------------------------------------------------------'), nl,

    acquisisci_dato_dt(DT1),                                                       
    calc_fugoide_completo(DT1, FC),
    write(FC),                                                                     nl,

    write('--------------------------------------------------------------------'), nl,
    write('| Calcolo dell\' equazione di convezione lineare a una dimensione   |'), nl,
    write('| Parametri iniziali:                                              |'), nl,
    write('| estremo superiore del dominio spaziale   = 2.0,                  |'), nl,
    write('| estremo inferiore del dominio spaziale   = 0.0,                  |'), nl, 
    write('| valore della parte alta della funzione   = 2.0,                  |'), nl, 
    write('| valore della parte bassa della funzione  = 1.0.                  |'), nl,
    write('| Parametri di simulazione:                                        |'), nl,
    write('| numero di passi temporali da effettuare  = 25,                   |'), nl, 
    write('| velocita\' dell\'onda                      = 1.0.                  |'), nl, 
    write('| Parametri richiesti all\'utente:                                  |'), nl, 
    write('| numero di punti che compongono la funzione d\'onda,               |'), nl,
    write('| un valore alto permette una simulazione piu\' accurata.           |'), nl,
    write('| Il valore del numero di punti dell\'onda deve essere un naturale. |'), nl,
    write('| Passo temporale, determina la distanza temporale                 |'), nl,
    write('| tra due punti di simulazione, un valore basso                    |'), nl,
    write('| permette una simulazione piu\' accurata.                          |'), nl,
    write('| Il valore del passo temporale deve essere maggiore di zero.      |'), nl,
    write('--------------------------------------------------------------------'), nl,

    acquisisci_dati_conv(NXC,DT2),                                                 
    calc_convezione(NXC,DT2,CONV), 
    write(CONV),                                                                   nl,

    write('--------------------------------------------------------------------'), nl,
    write('| Calcolo dell\'equazione di Burgers a una dimensione               |'), nl,
    write('| Parametri iniziali:                                              |'), nl,
    write('| estremo superiore del dominio spaziale   = 2.0 * pi,             |'), nl,
    write('| estremo inferiore del dominio spaziale   = 0.0.                  |'), nl, 
    write('| Parametri di simulazione:                                        |'), nl,
    write('| tempo finale di simulazione              = 0.6s,                 |'), nl, 
    write('| coefficiente di diffusione               = 1.0m^2/s,             |'), nl, 
    write('| costante di Courant-Friedrichs-Lewy      = 0.1.                  |'), nl, 
    write('| Parametri richiesti all\'utente:                                  |'), nl, 
    write('| numero di punti che compongono la funzione d\'onda.               |'), nl,
    write('| Il valore del numero di punti dell\'onda deve essere un naturale. |'), nl,
    write('--------------------------------------------------------------------'), nl,

    acquisisci_dato_nxb(NXB),                                                          
    calc_burgers(NXB,BURG),
    write(BURG).


/* Inizio sezione input/output */
   

/* Il predicato acquisisci_dato_dt acquisisce un parametro numerico
   reale positivo di simulazione, ovvero la lunghezza del passo temporale. */

acquisisci_dato_dt(DT) :- write('Digita lunghezza del passo temporale: '),
                          read(DTV),
                          DTV > 0,
                          DT is DTV,
                          !;     
                          write('Acquisizione errata!'), nl,
                          write('Il valore deve essere maggiore di zero.'), nl,
                          acquisisci_dato_dt(DT).


/* Il predicato acquisisci_dati_conv acquisisce due parametri numerici
   di simulazione per l'equazione di convezione: il primo, un naturale per il 
   numero di punti della funzione d'onda; il secondo un reale positivo 
   per la lunghezza del passo temporale. */

acquisisci_dati_conv(NX,DT) :- write('Digita il numero di punti totali della funzione d\'onda: '),
                               read(NXV),
                               integer(NXV),
                               acquisisci_dato_nxc(NXV,NX,DT),
                               !;     
                               write('Acquisizione errata!'), nl,
                               write('Il valore deve essere un numero naturale.'), nl,
                               acquisisci_dati_conv(NX,DT).

acquisisci_dato_nxc(NX,NX,_)  :- (NX == 0;
                                  NX == 1).
acquisisci_dato_nxc(NX,NX,DT) :- NX > 1,
                                 acquisisci_dato_dt(DT).


/* Il predicato acquisisci_dato_nxb acquisisce un parametro numerico
   naturale di simulazione, ovvero il numero totale di punti della funzione
   d'onda per il calcolo dell'equazione di Burgers. */

acquisisci_dato_nxb(NX) :- write('Digita il numero di punti totali della funzione d\'onda: '),
                           read(NXV),
                           integer(NXV),
                           NXV >= 0,
                           NX is NXV,
                           !;     
                           write('Acquisizione errata!'), nl,
                           write('Il valore deve essere un numero naturale.'), nl,
                           acquisisci_dato_nxb(NX).

      
/* Fine sezione input/output */


/* Inizio sezione fugoide semplice */


/* Il predicato calc_fugoide_semplice calcola il moto fugoide con attrito di 
   un velivolo generico:
   - il primo argomento   e' la lunghezza del passo temporale dt;
   - il secondo argomento e' la funzione di traiettoria risultante. */

calc_fugoide_semplice(DT,[Z0|T]) :-  Z0 is 100.0,                    /* Altitudine iniziale del velivolo.             */
                                     B0 is 10.0,                     /* Angolo iniziale del velivolo.                 */
                                     PASSI is (floor(100.0/DT) + 1), /* Numero di punti in cui effettuare il calcolo. */
                                     calc_moto(Z0,B0,DT,PASSI,T).


/* Il predicato calc_moto calcola numericamente l'integrazione del moto fugoide:
   - il primo argomento   e' l'altitudine del velivolo;
   - il secondo argomento e' la velocita' del velivolo;
   - il terzo argomento   e' la lunghezza del passo temporale dt;
   - il quarto argomento  e' il numero di passi che sono ancora da effettuare;
   - il quinto argomento  e' una lista di valori numerici che rappresentano 
     l'altitudine del velivolo per ogni passo temporale. */

calc_moto(Y,V,DT,0,[YT])     :- passo_eulero(Y,V,DT,YT,_).  
calc_moto(Y,V,DT,LEN,[YT|T]) :- LEN > 0,
                                passo_eulero(Y,V,DT,YT,VT),
                                LEN1 is (LEN - 1),
                                calc_moto(YT,VT,DT,LEN1,T).


/* Il predicato passo_eulero applica il metodo di Eulero ad una coppia di numeri. Il
   predicato approssima la soluzione al tempo t_(n+1) tramite il valore del predicato 
   al tempo t_n ed un opportuno passo temporale: 
   - il primo argomento   e' l'altitudine del velivolo;
   - il secondo argomento e' la velocita' del velivolo;
   - il terzo argomento   e' la lunghezza del passo temporale dt;
   - il quarto argomento  e' l'altitudine del velivolo ricalcolata;
   - il quinto argomento  e' la velocita' del velivolo ricalcolata. */

passo_eulero(Y,V,DT,Y1,V1) :- derivata_u(Y,V,YT,VT),
                              Y1 is (Y + (YT * DT)),
                              V1 is (V + (VT * DT)).


/* Il predicato derivata_u viene utilizzato per l'applicazione dell'equazione del 
   moto fugoide:
   - il primo argomento   e' l'altitudine del velivolo;
   - il secondo argomento e' l'angolazione del velivolo;
   - il terzo argomento   e' l'altitudine del velivolo ricalcolata;
   - il quarto argomento  e' l'angolazione del velivolo ricalcolata. */

derivata_u(Y,V,V,V1) :- CG is 9.81,     /* Costante gravitazionale terrestre. */
                        ZT is 100.0,    /* Altitudine centrale all'oscillazione. */
                        V1 is CG * (1-Y/ZT).


/* Fine sezione fugoide semplice */


/* Inizio sezione fugoide completo */


/* Il predicato calc_fugoide_completo calcola il moto fugoide con attrito di 
   un velivolo generico:
   - il primo argomento   e' la lunghezza del passo temporale dt;
   - il secondo argomento e' la funzione di traiettoria risultante. */

  calc_fugoide_completo(DT,[[X0|Y0]|T]) :-  V0 is 30.0,                     /* La velocita' iniziale, in questo caso quella di trim.  */
                                            THETA0 is 0.0,                  /* Angolo iniziale del velivolo.                          */
                                            X0 is 0.0,                      /* Spostamento orizzontale iniziale del velivolo.         */
                                            Y0 is 1000.0,                   /* Altitudine iniziale del velivolo.                      */
                                            PASSI is (floor(100.0/DT) + 1), /* Numero di punti in cui effettuare il calcolo.          */
                                            calc_moto(V0,THETA0,X0,Y0,DT,PASSI,T).


/* Il predicato calc_moto calcola numericamente l'integrazione del moto fugoide:
   - il primo argomento   e' la velocita' del velivolo; 
   - il secondo argomento e' l'angolo del velivolo;
   - il terzo argomento   e' lo spostamento laterale del velivolo;
   - il quarto argomento  e' lo spostamento verticale del velivolo;
   - il quinto argomento  e' la lunghezza del passo temporale dt;
   - il sesto argomento   e' il numero di passi che sono ancora da effettuare;
   - il settimo argomento e' una lista di coppie di valori numerici che rappresentano 
     spostamento laterale e l'altitudine del velivolo per ogni passo temporale. */

calc_moto(V,THETA,X,Y,DT,0,[X1,Y1])       :- passo_eulero(V,THETA,X,Y,DT,_,_,X1,Y1).
calc_moto(V,THETA,X,Y,DT,LEN,[[X1|Y1]|T]) :- LEN > 0,
                                             passo_eulero(V,THETA,X,Y,DT,V1,THETA1,X1,Y1),
                                             LEN1 is (LEN - 1),
                                             calc_moto(V1,THETA1,X1,Y1,DT,LEN1,T).


/* Il predicato passo_eulero applica il metodo di Eulero ad una quadrupla di numeri. Il
   predicato approssima la soluzione al tempo t_(n+1) tramite il valore del predicato 
   al tempo t_n ed un opportuno passo temporale: 
   - il primo argomento   e' la velocita' del velivolo; 
   - il secondo argomento e' l'angolo del velivolo;
   - il terzo argomento   e' lo spostamento laterale del velivolo;
   - il quarto argomento  e' lo spostamento verticale del velivolo;
   - il quinto argomento  e' la lunghezza del passo temporale dt;
   - il sesto argomento   e' la velocita' del velivolo ricalcolata; 
   - il settimo argomento e' l'angolo del velivolo ricalcolato;
   - il ottavo argomento  e' lo spostamento laterale del velivolo ricalcolato;
   - il nono argomento    e' lo spostamento verticale del velivolo ricalcolato. */

passo_eulero(V,THETA,X,Y,DT,V1,THETA1,X1,Y1) :- derivata_u(V,THETA,VT,THETAT,XT,YT),
                                                V1      is (V + (VT * DT)),
                                                THETA1  is (THETA + (THETAT * DT)),
                                                X1      is (X + (XT * DT)),
                                                Y1      is (Y + (YT * DT)). 


/* Il predicato derivata_u viene utilizzato per l'applicazione dell'equazione del 
   moto fugoide:
   - il primo argomento   e' la velocita' del velivolo;
   - il secondo argomento e' l'angolazione del velivolo;
   - il terzo argomento   e' la velocita' del velivolo ricalcolata;
   - il quarto argomento  e' l'angolazione del velivolo ricalcolata;
   - il quinto argomento  e' lo spostamento laterale del velivolo ricalcolato;
   - il sesto argomento   e' lo spostamento verticale del velivolo ricalcolato. */

derivata_u(V,THETA,V1,THETA1,X1,Y1) :-  CG is 9.81,     /* Costante gravitazionale terrestre.   */
                                        CR is 0.025,    /* Coefficiente di resistenza all'aria. */
                                        CP is 1.0,      /* Coefficiente di portanza.            */
                                        VTRIM is 30.0,  /* Velocita' di trim del velivolo.      */
                                        V1 is (- (CG * sin(THETA)) - (CR / CP) * CG/VTRIM**2*V**2),
                                        THETA1 is (- (CG * cos(THETA) / V) + (CG/VTRIM**2*V)),
                                        X1 is (V * cos(THETA)),
                                        Y1 is (V * sin(THETA)).


/* Fine sezione fugoide completo */


/* Inizio sezione convezione lineare */


/* Il predicato calc_convezione calcola l'integrazione numerica
   dell'equazione di convezione lineare a una dimensione:
   - il primo argomento   e' il numero di punti totali della 
     funzione d'onda;
   - il secondo argomento e' la lunghezza del passo temporale;
   - il terzo argomento   e' l'integrazione numerica completa dell'equa-
     -zione lineare unidimensionale di convezione. */

calc_convezione(NX,_,F)  :- (NX == 0;
                             NX == 1),
                            INF is 0.0,                  /* Limite inferiore del dominio spaziale. */
                            SUP is 2.0,                  /* Limite superiore del dominio spaziale. */
                            cond_iniziale_conv(NX,INF,SUP,F).
calc_convezione(NX,DT,F) :- NX > 1,
                            NT  is 25,                   /* Numero complessivo di passi temporali
                                                            che deve effettuare l'algoritmo.       */
                            NX1 is NX - 1,
                            C   is 1.0,                  /* Velocita' dell'onda.                   */
                            INF is 0.0,                  /* Limite inferiore del dominio spaziale. */
                            SUP is 2.0,                  /* Limite superiore del dominio spaziale. */
                            DX  is abs(SUP - INF) / NX1, /* Distanza tra qualsiasi coppia di
                                                            punti della griglia adiacenti.         */
                            cond_iniziale_conv(NX,INF,SUP,ONDA),
                            tempo_conv(0,NT,NX1,C,DX,DT,ONDA,F).


/* Il predicato tempo_conv calcola numericamente l'integrazione della
   funzione rispetto al parametro temporale DT:
   - il primo argomento   e' il numero di passi temporali che la funzione
     d'onda ha compiuto;
   - il secondo argomento e' il numero di passi temporali totali che la
     funzione d'onda deve compiere; 
   - il terzo argomento   e' il numero di passi spaziali utilizzati dal
     predicato spazio_conv;
   - il quarto argomento  e' la costante di velocità dell'onda;     
   - il quinto argomento  e' la lunghezza del passo spaziale;
   - il sesto argomento   e' la lunghezza del passo temporale;
   - il settimo argomento e' la funzione d'onda ricalcolata;
   - l' ottavo argomento  e' la funzione d'onda risultante. */

tempo_conv(NT,NT,_,_,_,_,F,F).
tempo_conv(I,NT,NX1,C,DX,DT,ONDA,F) :- I < NT,
                                       I1  is I + 1,
                                       testa(ONDA,T),                
                                       spazio_conv(0,NX1,C,DX,DT,ONDA,F1), 
                                       inserisci_elem(T,F1,R),                
                                       tempo_conv(I1,NT,NX1,C,DX,DT,R,F). 


/* Il predicato spazio_conv calcola numericamente l'integrazionee della
   funzione rispetto al parametro spaziale DX:
   - il primo argomento   e' il numero di passi temporali che la funzione
     d'onda ha compiuto;
   - il secondo argomento e' il numero di passi temporali totali che la
     funzione d'onda deve compiere; 
   - il terzo argomento   e' la costante di velocità dell'onda;      
   - il quarto argomento  e' la lunghezza del passo spaziale;
   - il quinto argomento  e' la lunghezza del passo temporale;
   - il sesto argomento   e' la funzione d'onda;
   - il settimo argomento e' la funzione d'onda ricalcolata con 
     passo_eulero_conv. */

spazio_conv(NX1,NX1,_,_,_,_,[]).
spazio_conv(I,NX1,C,DX,DT,[E0|LX],[E|T]) :- I < NX1,
                                            I1 is I + 1,
                                            testa(LX,E1),
                                            passo_eulero_conv(E0,E1,C,DX,DT,EU),
                                            E  is EU,
                                            spazio_conv(I1,NX1,C,DX,DT,LX,T).


/* Il predicato passo_eulero_conv effettua il passo di Eulero:
   - il primo argomento   e' l'elemento corrente della lista;
   - il secondo argomento e' l'elemento successivo a quello corrente della lista;
   - il terzo argomento   e' la costante di velocità dell'onda;
   - il quarto argomento  e' la lunghezza del passo spaziale;
   - il quinto argomento  e' la lunghezza del passo temporale;
   - il sesto argomento   e' il valore risultante del punto applicato il passo di Eulero. */

passo_eulero_conv(E0,E1,C,DX,DT,EU) :- EU is E1 - C * (DT/DX) * (E1 - E0).


/* Il predicato cond_iniziale_conv calcola la condizione iniziale (una funzione)
   per l'integrazione numerica dell'equazione di convezione:
   - il primo argomento   e' il numero di punti della griglia spaziale;
   - il secondo argomento e' l'estremo inferiore del dominio spaziale;
   - il terzo argomento   e' l'estremo superiore del dominio spaziale; 
   - il quarto argomento  e' la funzione d'onda quadra. */

cond_iniziale_conv(NX,INF,SUP,ONDA) :- gen_punti_equi(NX,INF,SUP,L),
                                       onda_quadra(L,ONDA).


/* Il predicato onda_quadra calcola la funzione d'onda quadra:
   - il primo argomento   e' la lista di punti equidistanti del dominio
     spaziale;
   - il secondo argomento e' la funzione d'onda calcolata. */

onda_quadra([],[]).
onda_quadra([X|L1],[OSI|T]) :- X >= 0.5,
                               X =< 1.0,
                               OSI is 2.0,   /* Valori assunti dalla parte alta della
                                                funzione d'onda quadra. */
                               onda_quadra(L1,T).
onda_quadra([X|L1],[OSI|T]) :- (X < 0.5; 
                                X > 1.0),
                               OSI is 1.0,   /* Valori assunti dalla parte bassa della
                                                funzione d'onda quadra. */
                               onda_quadra(L1,T).


/* Fine sezione convezione lineare */


/* Inizio sezione equazione di Burgers */


/* Il predicato calc_burgers calcola l'integrazione numerica
   dell'equazione di Burgers a una dimensione:
   - il primo argomento e' il numero di punti totali della funzione
     d'onda;
   - il secondo argomento e' l'integrazione numerica completa dell'equa-
     -zione lineare unidimensionale di Burgers.*/

calc_burgers(NX,F) :- (NX == 0;
                       NX == 1),
                      INF is 0.0,         /* Limite inferiore del dominio spaziale. */
                      SUP is 2.0 * pi,    /* Limite superiore del dominio spaziale. */
                      cond_iniziale_burg(NX,INF,SUP,F).
calc_burgers(NX,F) :- NX1 is NX - 1,
                      T   is 0.6,                  /* Tempo totale di simulazione.                */
                      S   is 0.1,                  /* Costante di Courant-Friendrichs-Lewy (CFL). */
                      NU  is 0.07,                 /* Coefficiente di diffusione.                 */
                      INF is 0.0,                  /* Limite inferiore del dominio spaziale.      */
                      SUP is 2.0 * pi,             /* Limite superiore del dominio spaziale.      */
                      DX  is abs(SUP - INF) / NX1, /* Distanza tra qualsiasi coppia di punti
                                                      della griglia adiacenti.                    */
                      DT  is S * DX^2 / NU,        /* Lunghezza del passo temporale.              */
                      NT  is floor(T/DT),          /* Numero complessivo di passi temporali
                                                      che deve effettuare l'algoritmo.            */
                      cond_iniziale_burg(NX,INF,SUP,ONDA),
                      tempo_burg(0,NT,NX1,NU,DX,DT,ONDA,F).


/* Il predicato tempo_burg calcola numericamente l'integrazione della
   funzione rispetto al parametro temporale DT:
   - il primo argomento e' il numero di passi temporali che la funzione
     d'onda ha compiuto;
   - il secondo argomento e' il numero di passi temporali totali che la
     funzione d'onda deve compiere; 
   - il terzo argomento e' il numero di passi spaziali utilizzati dal
     predicato spazio_burg;
   - il quarto argomento e' il coefficiente di diffusione;         
   - il quinto argomento e' la lunghezza del passo spaziale;
   - il sesto argomento e' la lunghezza del passo temporale;
   - il settimo argomento e' la funzione d'onda ricalcolata;
   - l' ottavo argomento e' la funzione d'onda risultante. */

tempo_burg(NT,NT,_,_,_,_,F,F).
tempo_burg(I,NT,NX1,NU,DX,DT,ONDA,F) :- I < NT,
                                        I1  is I + 1,
                                        bordo_inf(ONDA,NU,DX,DT,BI),
                                        spazio_burg(1,NX1,NU,DX,DT,ONDA,Z),
                                        inserisci_elem(BI,Z,R),
                                        tempo_burg(I1,NT,NX1,NU,DX,DT,R,F).


/* Il predicato spazio_burg calcola numericamente l'integrazione della
   funzione rispetto al parametro spaziale DX:
   - il primo argomento   e' l'indice per accedere agli elementi della 
     lista, viene utlizzato da passo_eulero; 
   - il secondo argomento e' il numero di punti della funzione; 
   - il terzo argomento   e' il coefficiente di diffusione;  
   - il quarto argomento  e' la lunghezza del passo spaziale;
   - il quinto argomento  e' la lunghezza del passo temporale;
   - il sesto argomento   e' la funzione d'onda;
   - il settimo argomento e' la funzione d'onda ricalcolata con 
     il passo_eulero_burg e bordo_sup. */

spazio_burg(NX1,NX1,NU,DX,DT,ONDA,[F]) :- bordo_sup(ONDA,NU,DX,DT,F).
spazio_burg(I,NX1,NU,DX,DT,ONDA,[E|F]) :- I < NX1,
                                          I1 is I + 1,
                                          passo_eulero_burg(ONDA,I,NU,DX,DT,E),
                                          spazio_burg(I1,NX1,NU,DX,DT,ONDA,F).


/* Il predicato bordo_inf calcola le condizioni di bordo inferiore della funzione:
   - il primo argomento   e' la funzione d'onda;
   - il secondo argomento e' il coefficiente di diffusione;
   - il terzo argomento   e' la lunghezza del passo spaziale;
   - il quarto argomento  e' la lunghezza del passo temporale;
   - il quinto argomento  e' il valore del punto estremo inferiore della funzione.
   L'uso di last e testa consente di selezionare gli elementi in coda e in testa
   alla funzione per il calcolo della condizione. */

bordo_inf([X|LX],NU,DX,DT,BI) :- last(LX,C),
                                 testa(LX,T),
                                 BI is X - X*DT/DX * (X - C) + NU*DT/DX^2 * (T - 2*X + C).


/* Il predicato bordo_sup calcola le condizioni di bordo superiore della funzione:
   - il primo argomento   e' la funzione d'onda;
   - il secondo argomento e' il coefficiente di diffusione;
   - il terzo argomento   e' la lunghezza del passo spaziale;
   - il quarto argomento  e' la lunghezza del passo temporale;
   - il quinto argomento  e' il valore del punto estremo superiore della funzione.
   L'uso di last, testa e penultimo consente di selezionare l'ultimo, il primo e
   il penultimo elemento della funzione per il calcolo della condizione. */

bordo_sup(ONDA,NU,DX,DT,BS) :- last(ONDA,C),
                               penultimo(ONDA,P),
                               testa(ONDA,T),
                               BS is C - C*DT/DX * (C - P) + NU*DT/DX^2 * (T - 2*C + P).


/* Il predicato passo_eulero_burg effettua il passo di Eulero:
   - il primo argomento   e' la funzione d'onda;
   - il secondo argomento e' l'indice dell'elemento corrente della lista;
   - il terzo argomento   e' il coefficiente di diffusione;
   - il quarto argomento  e' la lunghezza del passo spaziale;
   - il quinto argomento  e' la lunghezza del passo temporale;
   - il sesto argomento   e' il valore risultante del punto applicato il passo di Eulero.
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
   - il primo argomento   e' il numero di punti della griglia spaziale;
   - il secondo argomento e' l'estremo inferiore del dominio spaziale;
   - il terzo argomento   e' l'estremo superiore del dominio spaziale; 
   - il quarto argomento  e' la funzione "onda a dente di sega". */

cond_iniziale_burg(NX,INF,SUP,ONDA) :- gen_punti_equi(NX,INF,SUP,L),
                                       onda_dente_sega(L,ONDA).


/* Il predicato onda_dente_sega calcola la funzione d'onda a dente di 
   sega 'u':
   - il primo argomento   e' la lista di punti equidistanti del dominio
     spaziale;
   - il secondo argomento e' la funzione d'onda calcolata. 
   Per il calcolo dell'onda si fa uso dei predicati phi e phi_primo
   che sono rispettavamente la funzione e la sua derivata. */

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


/* Fine sezione equazione di Burgers */


/* Inizio sezione funzioni condivise */


/* Il predicato gen_punti_equi genera una lista di punti equidistanti tra loro:
   - il primo argomento   e' il numero di punti che si vuole generare;
   - il secondo argomento e' l'estremo inferiore della lista di punti;
   - il terzo argomento   e' l'estremo superiore della lista di punti;
   - il quarto argomento  e' la lista di punti equidistanti. 
   Per il calcolo dei punti si fa uso del predicato calc_punti. */

gen_punti_equi(0,_,_,[]).
gen_punti_equi(N,INF,SUP,L) :- N > 0,
                               DST is abs(SUP - INF),
                               N1  is N - 1, 
			                      ((SUP > INF,
                                calc_punti(0,N1,INF,DST,L));
                                (calc_punti(0,N1,SUP,DST,L1),
                                reverse(L1,L))).


calc_punti(N1,N1,INF,_,[INF]).
calc_punti(I,N1,INF,DST,[INF|L]) :- I < N1,
                                    I1   is I + 1,
                                    INF1 is INF + (DST/N1),
                                    calc_punti(I1,N1,INF1,DST,L).

/* Predicato che inserisce un elemento in testa alla lista. */

inserisci_elem(X,L,[X|L]).


/* Predicato che estrae la lista di elementi successivi al primo. */

estrai_lista([_|LX],LX).


/* Predicato per estrarre il primo elemento di una lista. */

testa([X|_],X).


/* Predicato che restituisce il penultimo elemento di una lista. */

penultimo(LX,X) :- reverse(LX,LXInv),
                   estrai_lista(LXInv,Y),
                   testa(Y,X).


/* Predicato per aggiungere un elemento alla fine di una lista. */

accoda_elem(X,[],[X]).
accoda_elem(X,[Y|L],[Y|LX]) :- accoda_elem(X,L,LX).


/* Fine sezione funzioni condivise */