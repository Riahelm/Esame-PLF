
main :-
    nl,
    write('Progetto della sessione autunnale del corso Programmazione Logica e Funzionale'), nl,
    write('Anno 2021/2022'), nl,
    write('Corso tenuto dal prof. Marco Bernardo'), nl,
    write('Progetto realizzato da: Barzotti Nicolas e Ramagnano Gabriele'), nl, nl, nl,

    write('Calcolo del moto di fugoide senza attrito'), nl,
    write('Digita la lunghezza del passo temporale: '), nl,
    acquisisci_dato(DT),
    main_fugoide_semplice(DT, FS),
    mostra_dati_lista(FS),

    write('Calcolo del moto di fugoide con attrito'), nl, 
    write('Digita la lunghezza del passo temporale: '), nl,
    acquisisci_dato(DT),
    main_fugoide_completo(DT, FC),
    mostra_dati_lista(FC),

    write('Calcolo della equazione di convezione lineare a una dimensione'),
    write('Digita il numero di punti totali della funzione di onda: '),
    acquisisci_dato(NX),
    write('Digita la lunghezza del passo temporale della funzione di onda: '),
    acquisisci_dato(DT),
    main_convezione(DT, NX, CONV),
    mostra_dati_lista(CONV),

    write('Calcolo della equazione di Burgers a una dimensione'),
    write('Digita il numero di punti totali della funzione di onda: '),
    acquisisci_dato(NX),
    main_burgers(NX, BURG),
    mostra_dati_lista(BURG),