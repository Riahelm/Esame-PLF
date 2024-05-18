/*********************************_ATTENZIONE_***************************************
  - I predicati last,testa, estrai_lista e nth NON ammettono LISTA VUOTA. Inoltre il
    predicato penultimo inoltre deve ricevere in ingresso una lista di ALMENO 2 ele-
    -menti. In particolare:

    - bordo_inf,    ERROR! se la lista di ingresso non è di almeno 2 elementi;
    - bordo_sup,    ERROR! se la lista di ingresso non è di almeno 2 elementi;
    - passo_eulero, ERROR! se la lista in ingresso non è di almeno 3 elementi; inol-
      -tre l'indice I deve essere un INTERO e partire dal primo elemento della lista.
      Poiché gli elementi sono indicizzati (nth) da 1 a N, I deve essere diverso da 0.
*************************************************************************************/



/* Il predicato bordo_inf calcola le condizioni di bordo inferiore della funzione:
   - il primo termine è la funzione d'onda;
   - il secondo termine è il coefficiente di diffusione;
   - il terzo termine è la lunghezza del passo spaziale;
   - il quarto termine è la lunghezza del passo temporale;
   - il quinto termine è il valore del punto estremo inferiore della funzione. 
   L'uso di last e testa consente di selezionare gli elementi in coda e in testa
   alla funzione per il calcolo della condizione */
   
bordo_inf([X|LX],NU,DX,DT,BI) :- last(LX,C),
                                 testa(LX,T),
                                 BI is X - X*DT/DX * (X - C) + NU*DT/DX^2 * (T - 2*X + C).

/* Il predicato bordo_sup calcola le condizioni di bordo superiore della funzione:
   - il primo termine è la funzione d'onda;
   - il secondo termine è il coefficiente di diffusione;
   - il terzo termine è la lunghezza del passo spaziale;
   - il quarto termine è la lunghezza del passo temporale;
   - il quinto termine è il valore del punto estremo superiore della funzione. 
   L'uso di last, testa e penultimo consente di selezionare l'ultimo, il primo e 
   il penultimo elemento della funzione per il calcolo della condizione */

bordo_sup(ONDA,NU,DX,DT,BS) :- last(ONDA,C),
                               penultimo(ONDA,P),
                               testa(ONDA,T),
                               BS is C - C*DT/DX * (C - P) + NU*DT/DX^2 * (T - 2*C + P). 


/* Il predicato passo_eulero effettua il passo di Eulero:
   - il primo termine è la funzione d'onda;
   - il secondo termine è l'indice dell'elemento corrente della lista;
   - il terzo termine è il coefficiente di diffusione;
   - il quarto termine è la lunghezza del passo spaziale;
   - il quinto termine è la lunghezza del passo temporale;
   - il sesto termine è il valore risultante del punto applicato il passo di eulero.
   L'uso del predicato nth consente di accedere agli elementi della lista tramite
   indice. Gli elementi sono indicizzati da 1 a N. */

passo_eulero_burg(ONDA,I0,NU,DX,DT,EU) :- I1 is I0 + 1,
                                          I2 is I1 + 1,
		                          nth(I0,ONDA,E0),
		  	                  nth(I1,ONDA,E1),
		    	                  nth(I2,ONDA,E2),
                                          EU is E1 - E1*DT/DX * (E1 - E0) + NU*DT/DX^2 * (E2 - 2*E1 + E0).



