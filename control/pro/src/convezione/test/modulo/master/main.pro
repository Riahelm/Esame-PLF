/* Predicato MAIN */
calc_convezione(NX,DT,F) :- NT  is 25,
                            NX1 is NX - 1,
                            C   is 1.0,
                            INF is 0.0,
                            SUP is 2.0,
                            DX  is SUP / NX1,
                            cond_iniziale_conv(NX,INF,SUP,ONDA),
                            tempo_conv(0,NT,NX1,C,DX,DT,ONDA,F).


/**********************_INPUT_EXAMPLES_************************

   NX = 41   -- numero di punti della griglia spaziale;
   DT = 0.02 -- lunghezza passo temporale.

*_nota1: i parametri IN e SUP sono numeri reali; N deve essere 
intero: il controllo viene demandato al predicato gen_punti_equi

***************************************************************/
