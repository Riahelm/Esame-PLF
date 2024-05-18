/* Predicato MAIN */
calc_burgers(NX,F) :- NX1 is NX - 1, 
                      T   is 0.6,
                      S   is 0.1,
                      NU  is 0.07,
                      INF is 0.0,
                      SUP is 2.0 * pi,
                      DX  is SUP / NX1,
                      DT  is S * DX^2 / NU,
                      NT  is floor(T/DT),
                      cond_iniziale(NX,INF,SUP,ONDA),
                      conv_tempo(0,NT,NX1,NU,DX,DT,ONDA,F).
