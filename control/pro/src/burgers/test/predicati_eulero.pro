/* Predicato per il calcolo delle condizioni di bordo inferiore */
condBordoInf([X|LX],NU,DX,DT,BI) :- coda(LX,C),
                                    estrai_elem(LX,T),
                                    BI is X - X*DT/DX * (X - C) + NU*DT/DX^2 * (T - 2*X + C).

/* Predicato per il calcolo delle condizioni di bordo superiore */
condBordoSup(NU,DX,DT,ONDA,BS) :- coda(ONDA,C),
                                  penultimo(ONDA,P),
                                  estrai_elem(ONDA,T),
                                  BS is C - C*DT/DX * (C - P) + NU*DT/DX^2 * (T - 2*C + P). 


/* Predicato che effettua il passo di Eulero */
 passoEulero(I,NU,DX,DT,ONDA,EU) :- I0 is I  - 1,
                                    I2 is I  + 1,
				                    estrai(0,I0,ONDA,E0),
			                        estrai(0,I,ONDA,E1),
		    	                    estrai(0,I2,ONDA,E2),
                                    EU is E1 - E1*DT/DX * (E1 - E0) + NU*DT/DX^2 * (E2 - 2*E1 + E0).