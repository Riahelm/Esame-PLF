module Coppia where
    {-  Tipo di dato che rappresenta una coppia di elementi uguali -}
    type Coppia a = (a,a)
    
    {-  Funzione che prende due coppie dello stesso tipo e restituisce la coppia risultante dalla somma rispettiva degli elementi -}
    somma_coppia :: (Num a) => Coppia a -> Coppia a -> Coppia a
    somma_coppia (a1,b1) (a2,b2) = (a1+a2, b1+b2)
    
    {-  Funzione che prende una coppia e un valore numerico per poi restituire la coppia risultante dalla somma rispettiva di ogni
        elemento della coppia per il valore numerico 
    -}
    moltiplica_coppia_per_scalare :: (Num a) => Coppia a -> a -> Coppia a
    moltiplica_coppia_per_scalare (a1,b1) b = (a1*b, b1*b)