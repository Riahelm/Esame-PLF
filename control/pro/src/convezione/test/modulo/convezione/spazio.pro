/*********************************_ATTENZIONE_***************************************
 Il predicato testa non accetta una lista vuota. Per evitare stack overflow si neces-
 -sita che:
 - la lista sia di ALMENO 2 elementi,
 - su una lista di NX elementi: I is 0, NX1 is NX - 1.
 In questo modo si compiono esattamente NX1 iterazioni.
 Indici e numero di punti della lista devono essere degli interi: validazione nel 
 main!

*************************************************************************************/




/* Il predicato spazio_conv calcola numericamente l'integrale della
   funzione rispetto al parametro spaziale DX:
   - il primo termine è il numero di passi temporali che la funzione
     d'onda ha compiuto;
   - il secondo termine è il numero di passi temporali totali che la
     funzione d'onda deve compiere; 
   - il terzo termine è la costante di velocità dell'onda; 	
   - il quarto termine è la lunghezza del passo spaziale;
   - il quinto termine è la lunghezza del passo temporale;
   - il sesto termine è la funzione d'onda;
   - il settimo termine è la funzione d'onda ricalcolata con il passo_
     eulero */

spazio_conv(NX1,NX1,_,_,_,_,[]). 
spazio_conv(I,NX1,C,DX,DT,[E0|LX],[E|T]) :- I < NX1,
                                            I1 is I + 1,
                                            testa(LX,E1),
                                            passo_eulero_conv(E0,E1,C,DX,DT,EU),
                                            E  is EU,                                                                         
                                            spazio_conv(I1,NX1,C,DX,DT,LX,T).



