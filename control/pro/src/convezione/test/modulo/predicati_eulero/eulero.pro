/* Il predicato passo_eulero effettua il passo di Eulero:
   - il primo termine è l'elemento corrente della lista;
   - il secondo termine è l'elemento successivo a quello corrente della lista;
   - il terzo termine è la costante di velocità dell'onda;
   - il quarto termine è la lunghezza del passo spaziale;
   - il quinto termine è la lunghezza del passo temporale;
   - il sesto termine è il valore risultante del punto applicato il passo di eulero.
*/

passo_eulero_conv(E0,E1,C,DX,DT,EU) :- EU is E1 - C * (DT/DX) * (E1 - E0). 

