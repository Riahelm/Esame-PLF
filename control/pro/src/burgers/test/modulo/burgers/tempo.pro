/* Il predicato tempo_burg calcola numericamente l'integrale della
   funzione rispetto al parametro temporale DT:
   - il primo termine è il numero di passi temporali che la funzione
     d'onda ha compiuto;
   - il secondo termine è il numero di passi temporali totali che la
     funzione d'onda deve compiere; 
   - il terzo termine è il numero di passi spaziali utilizzati dal
     predicato conv_spazio;
   - il quarto termine è il coefficiente di diffusione; 	
   - il quinto termine è la lunghezza del passo spaziale;
   - il sesto termine è la lunghezza del passo temporale;
   - il settimo termine è la funzione d'onda ricalcolata;
   - l' ottavo termine è la funzione d'onda risultante. */

tempo_burg(NT,NT,_,_,_,_,F,F). 
tempo_burg(I,NT,NX1,NU,DX,DT,ONDA,F) :- I < NT,
                                        I1  is I + 1,
		  	                bordo_inf(ONDA,NU,DX,DT,BI),                    
				        spazio_burg(1,NX1,NU,DX,DT,ONDA,Z),
				        inserisci_elem(BI,Z,R),
                                        tempo_burg(I1,NT,NX1,NU,DX,DT,R,F).


