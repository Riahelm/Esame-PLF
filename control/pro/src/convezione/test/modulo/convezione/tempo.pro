/* Il predicato tempo_conv calcola numericamente l'integrale della
   funzione rispetto al parametro temporale DT:
   - il primo termine è il numero di passi temporali che la funzione
     d'onda ha compiuto;
   - il secondo termine è il numero di passi temporali totali che la
     funzione d'onda deve compiere; 
   - il terzo termine è il numero di passi spaziali utilizzati dal
     predicato conv_spazio;
   - il quarto termine è la costante di velocità dell'onda; 	
   - il quinto termine è la lunghezza del passo spaziale;
   - il sesto termine è la lunghezza del passo temporale;
   - il settimo termine è la funzione d'onda ricalcolata;
   - l' ottavo termine è la funzione d'onda risultante. */

tempo_conv(NT,NT,_,_,_,_,F,F).
tempo_conv(I,NT,NX1,C,DX,DT,ONDA,F) :- I < NT,
                                       I1  is I + 1,
                                       testa(ONDA,T),                
                                       spazio_conv(0,NX1,C,DX,DT,ONDA,F1), 
                                       inserisci_elem(T,F1,R),                
                                       tempo_conv(I1,NT,NX1,C,DX,DT,R,F). 

