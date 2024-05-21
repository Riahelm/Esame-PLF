
/* Il predicato acquisisci_dato_nx acquisisce l'input dell'utente 
   sui punti totali della funzione e ne controlla la validità:
   - Il primo termine è il messaggio da stampare a schermo ed indica
     cosa deve essere acquisito;
   - Il secondo è il numero di punti totali della funzione. */

acquisisci_dato_nx(MSG,NX) :- write(MSG),
                              read(NXV),
                              integer(NXV),
			      NXV > 0,
			      NX is NXV,
		   	      write('Valore accettato'),
			      !;     
                              write('Inserimento errato!'), nl,
                              acquisisci_dato_nx(MSG,NX).


/* Il predicato acquisisci_dato_nx acquisisce l'input dell'utente 
   sulla lunghezza del passo temporale e ne controlla la validità:
   - Il primo termine è il messaggio da stampare a schermo ed indica
     cosa deve essere acquisito;
   - Il secondo è la lunghezza del passo temporale. */

acquisisci_dato_dt(MSG,DT) :- write(MSG),
                              read(DTV),
			      DTV > 0,
			      DT is DTV,
		   	      write('Valore accettato'),
			      !;     
                              write('Inserimento errato!'), nl,
                              acquisisci_dato_dt(MSG,DT).


                             
				



