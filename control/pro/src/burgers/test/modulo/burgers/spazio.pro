/*********************************_ATTENZIONE_***************************************
 L'indice utilizzato da passo_eulero per accedere agli elementi della lista deve es-
 -sere maggiore di 0. Tuttavia, affinchè vengano effettuate NX - 1 iterazioni, per 
 evitare uno stack overflow per accessi errati sugli elementi della lista:
 - I   is 1,
 - NX1 is NX - 1,
 - passo_eulero prende I.
 Indici e numero di punti della lista devono essere degli interi: validazione nel 
 main!

*************************************************************************************/




/* Il predicato conv_spazio calcola numericamente l'integrale della
   funzione rispetto al parametro spaziale DX:
   - il primo termine è l'indice per accedere agli elementi della 
     lista, viene utlizzato da passo_eulero; 
   - il secondo termine è il numero di punti della funzione; 
   - il terzo termine è il coefficiente di diffusione; 	
   - il quarto termine è la lunghezza del passo spaziale;
   - il quinto termine è la lunghezza del passo temporale;
   - il sesto termine è la funzione d'onda;
   - il settimo termine è la funzione d'onda ricalcolata con il passo_
     eulero e bordo_sup. */

spazio_burg(NX1,NX1,NU,DX,DT,ONDA,[F]) :- bordo_sup(ONDA,NU,DX,DT,F).
spazio_burg(I,NX1,NU,DX,DT,ONDA,[E|F]) :- I < NX1,
                                          I1 is I + 1,
		   		          passo_eulero_burg(ONDA,I,NU,DX,DT,E),
				          spazio_burg(I1,NX1,NU,DX,DT,ONDA,F).


