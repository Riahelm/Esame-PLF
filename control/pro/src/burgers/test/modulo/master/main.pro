
main :-
    nl,
    write('------------------------------------TESTING-----------------------------------'), nl,
    write('Programma di testing dei predicati per la sezione di Programmazione Logica.   '), nl,
    write('ATTENZIONE: i test "fallimentari" sono stati commentati per non interrompere  '), nl,
    write('la esecuzione del programma.                                                  '), nl,
    nl,
    write('TEST 01: verifica del predicato per il calcolo di una lista di punti equidi-  '), nl, 
    write('-stanti:                                                                      '), nl,
    write('gen_punti_equi( N, INF, SUP, LN).                                             '), nl,
   %write('gen_punti_equi(-1,   0,  10, L0). '), gen_punti_equi(-1,0,10,L0),                 nl,
   %                                                                         write(L0),      nl,
   %write('gen_punti_equi( 0,   0,  10, L1). '), gen_punti_equi(0,0,10,L1),                  nl,				     
   %                                                                         write(L1),      nl,
    write('gen_punti_equi( 1,   0,  10, L2). '), gen_punti_equi(1,0,10,L2),                  nl,
                                                                             write(L2),      nl,
    write('gen_punti_equi(10,   1,  10, L3). '), gen_punti_equi(10,1,10,L3),                 nl,
                                                                             write(L3),      nl, 
    nl,
    write('SUP is 2.0 * pi, gen_punti_equi(201,  0.0,  2.0, L4). '), 
           SUP is 2.0 * pi, gen_punti_equi(201,  0.0,  SUP, L4),                             nl,
                                                                             write(L4),      nl, 
    nl,
    write('TEST 02: verifica del predicato per il calcolo della condizione iniziale:     '), nl,
    write('NX is 201, INF is 0.0, SUP is 2.0 * pi, cond_iniziale(NX, INF, SUP, L).       '), nl, 
           NX is 201, INF is 0.0, SUP is 2.0 * pi, cond_iniziale(NX, INF, SUP, M), write(M), nl. %% <--rem. 
    
                  
