calcConvSpazio(NX1,NX1,NU,DX,DT,ONDA,[F]) :- condBordoSup(NU,DX,DT,ONDA,F).
calcConvSpazio(I,NX1,NU,DX,DT,ONDA,[E|F]) :- I < NX1,
	                                         I1 is I + 1,
						                     passoEulero(I,NU,DX,DT,ONDA,E),
						                     calcConvSpazio(I1,NX1,NU,DX,DT,ONDA,F).


