
/* Il predicato calc_fugoide_completo calcola il moto fugoide con attrito di 
   un velivolo generico:
  - il primo argomento e' la lunghezza del passo temporale dt;
  - il secondo argomento e' la funzione di moto fugoide risultante. */

calc_fugoide_completo(DT,[Y0|T]) :-  V0 is 30.0,                     /* La velocita' iniziale, in questo caso quella di trim */
                                     THETA0 is 0.0,                  /* Angolo iniziale del velivolo */
                                     X0 is 0.0,                      /* Spostamento orizzontale iniziale del velivolo*/
                                     Y0 is 1000.0,                   /* Altitudine iniziale del velivolo */
                                     PASSI is (floor(100.0/DT) + 1), /* Numero di punti in cui effettuare il calcolo */
                                     calc_moto(V0,THETA0,X0,Y0,DT,PASSI,T).


/* La funzione calc_moto calcola numericamente l'integrazione del moto fugoide:
   - il primo argomento e' la velocita' del velivolo; 
   - il secondo argomento e' l'angolo del velivolo;
   - il terzo argomento e' lo spostamento laterale del velivolo;
   - il quarto argomento e' lo spostamento verticale del velivolo;
   - il quinto argomento e' la lunghezza del passo temporale dt;
   - il sesto argomento e' il numero di passi che sono ancora da effettuare;
   - il settimo argomento e' una lista di valori numerici che rappresentano 
     l'altitudine del velivolo per ogni passo temporale. */

calc_moto(V,THETA,X,Y,DT,0,[Y1])     :- passo_eulero(V,THETA,X,Y,DT,_,_,_,Y1).
calc_moto(V,THETA,X,Y,DT,LEN,[Y1|T]) :- LEN > 0,
                                        passo_eulero(V,THETA,X,Y,DT,V1,THETA1,X1,Y1),
                                        LEN1 is (LEN - 1),
                                        calc_moto(V1,THETA1,X1,Y1,DT,LEN1,T).

/* Il predicato passo_eulero applica il metodo di Eulero ad una coppia di numeri. La
   funzione approssima la soluzione al tempo t_(n+1) tramite il valore della funzione 
   al tempo t_n ed un opportuno passo temporale: 
   - il primo argomento e' la velocita' del velivolo; 
   - il secondo argomento e' l'angolo del velivolo;
   - il terzo argomento e' lo spostamento laterale del velivolo;
   - il quarto argomento e' lo spostamento verticale del velivolo;
   - il quinto argomento e' la lunghezza del passo temporale dt;
   - il sesto argomento e' la velocita' del velivolo; 
   - il settimo argomento e' l'angolo del velivolo;
   - il ottavo argomento e' lo spostamento laterale del velivolo;
   - il nono argomento e' lo spostamento verticale del velivolo. */

passo_eulero(V,THETA,X,Y,DT,V1,THETA1,X1,Y1) :- rhs(V,THETA,X,Y,VT,THETAT,XT,YT),
                                                V1      is (V + (VT * DT)),
                                                THETA1  is (THETA + (THETAT * DT)),
                                                X1      is (X + (XT * DT)),
                                                Y1      is (Y + (YT * DT)). 

/* Il predicato rhs ...??? */

rhs(V,THETA,_,_,V1,THETA1,X1,Y1) :- CG is 9.81,     /* Costante gravitazionale terrestre */
                                    CR is 0.025,    /* Coefficiente di resistenza all'aria */
                                    CP is 1.0,      /* Coefficiente di portanza */
                                    VTRIM is 30.0,  /* Velocita' di trim del velivolo */
                                    V1 is (- (CG * sin(THETA)) - (CR / CP) * CG/VTRIM**2*V**2),
                                    THETA1 is (- (CG * cos(THETA) / V) + (CG/VTRIM**2*V)),
                                    X1 is (V * cos(THETA)),
                                    Y1 is (V * sin(THETA)).


/* Il predicato calc_fugoide_semplice calcola il moto fugoide con attrito di 
   un velivolo generico:
  - il primo argomento e' la lunghezza del passo temporale dt;
  - il secondo argomento e' la funzione di moto fugoide risultante. */

calc_fugoide_semplice(DT,[Z0|T]) :-  Z0 is 100.0,                    /* Altitudine iniziale del velivolo*/
                                     B0 is 10.0,                     /* Angolo iniziale del velivolo */
                                     PASSI is (floor(100.0/DT) + 1), /* Numero di punti in cui effettuare il calcolo */
                                     calc_moto(Z0,B0,DT,PASSI,T).


/* La funzione calc_moto calcola numericamente l'integrazione del moto fugoide:
   - il primo argomento e' l'altitudine del velivolo;
   - il secondo argomento e' la velocita' del velivolo;
   - il terzo argomento e' la lunghezza del passo temporale dt;
   - il quarto argomento e' il numero di passi che sono ancora da effettuare;
   - il quinto argmoento e' una lista di valori numerici che rappresentano 
     l'altitudine del velivolo per ogni passo temporale. */

calc_moto(Y,V,DT,0,[YT])     :- passo_eulero(Y,V,DT,YT,_).  
calc_moto(Y,V,DT,LEN,[YT|T]) :- LEN > 0,
                                passo_eulero(Y,V,DT,YT,VT),
                                LEN1 is (LEN - 1),
                                calc_moto(YT,VT,DT,LEN1,T).


/* Il predicato passo_eulero applica il metodo di Eulero ad una coppia di numeri. La
   funzione approssima la soluzione al tempo t_(n+1) tramite il valore della funzione 
   al tempo t_n ed un opportuno passo temporale: 
   - il primo argomento e' l'altitudine del velivolo;
   - il secondo argomento e' la velocita' del velivolo;
   - il terzo argomento e' la lunghezza del passo temporale dt;
   - il quarto argomento e' l'altitudine del velivolo ricalcolata;
   - il quinto argomento e' la velocita' del velivolo ricalcolata. */

passo_eulero(Y,V,DT,Y1,V1) :- rhs(Y,V,YT,VT),
                              Y1 is (Y + (YT * DT)),
                              V1 is (V + (VT * DT)).


/* Il predicato rhs viene utilizzato per l'applicazione dell'equazione del 
   moto fugoide:
   - il primo argomento e' l'altitudine del velivolo;
   - il secondo argomento e' l'angolazione del velivolo;
   - il terzo argomento e' l'altitudine del velivolo ricalcolata;
   - il quarto argomento e' l'angolazione del velivolo ricalcolata. */

rhs(Y,V,V,V1) :- CG is 9.81,     /* Costante gravitazionale terrestre */
                 ZT is 100.0,    /* Altitudine centrale all'oscillazione */
                 V1 is CG * (1-Y/ZT).

