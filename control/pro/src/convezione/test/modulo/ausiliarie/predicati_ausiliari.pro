/*******************************************************************
                       PREDICATI AUSILIARI
 *******************************************************************/
  
 /* Predicato che inserisce un elemento in testa alla lista */ 
 %inserisci_elem(X, L, [X | L]).

 /* Predicato per estrarre il primo elemento di una lista */
 %estrai_elem([X|_], X).

/**************************************************************************************************
    			    RIDEFINIZIONI TRAMITE PREDICATI DI LIBRERIA
***************************************************************************************************/

 /* Predicato che inserisce un elemento in testa alla lista */ 
 inserisci_elem(X, L, [X | L]).

 /* Predicato per estrarre il primo elemento di una lista */
 testa([X|_], X).



 


