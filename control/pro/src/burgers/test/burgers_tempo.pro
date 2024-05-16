calcConvTempo(NT,NT,_,_,_,_,F,F). 
calcConvTempo(I,NT,NX1,NU,DX,DT,ONDA,F) :- I < NT,
                                           I1  is I + 1,
						                   condBordoInf(ONDA,NU,DX,DT,BI),                    
						                   calcConvSpazio(1,NX1,NU,DX,DT,ONDA,Z),
						                   inserisci_elem(BI,Z,R),
                                           calcConvTempo(I1,NT,NX1,NU,DX,DT,R,F).


