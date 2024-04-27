module Parametri where

 {- Parametri in ingresso per la risoluzione dell'equazione di convezione lineare a una dimensione -} -- Nota 2
 limiteSup :: Double
 limiteSup = 2.0                                {- limite superiore del dominio spaziale -}
 limiteInf :: Double
 limiteInf = 0.0                                {- limite inferiore del dominio spaziale -}  
 nx :: Int
 nx = 41                                        {- numero di punti della griglia spaziale -} -- Nota 1
 nt :: Int 
 nt = 25                                        {- numero complessivo di passi temporali che deve effettuare l'algoritmo -}
 dt :: Double
 dt = 0.02                                      {- lunghezza del passo temporale -}
 --dx :: Double
 --dx = limiteSup / (fromIntegral(nx :: Int) - 1) {- distanza tra qualsiasi coppia di punti della griglia adiacenti -}
 c :: Double
 c = 1.0                                        {- velocità dell'onda -}   
 ondaSup :: Double
 ondaSup = 2.0                                  {- valori assunti dalla parte alta della funzione d'onda quadra-} 
 ondaInf :: Double
 ondaInf = 1.0                                  {- valori assunti dalla parte bassa della funzione d'onda quadra-} 


 ------------------------------------------------------------------------------------------------------
 -- Nota 1: ricorda di utilizzare fromIntegral(nx :: Int) per convertire da Int a Num, altrimenti 
 -- non sarà possibile effettuare l'operazione di "conversione" con i tipi Double.

 -- Nota 2: inserire informazioni sullo stile di denominazione "scientifico" delle variabili ripre-
 -- -so dai notebook jupyter del corso di S.Numerica tenuto dal prof. A.Vicerè e sull'ordine di de-
 -- -finizione di variabili (dall'alto verso il basso o dal basso verso l'alto)

     
     

