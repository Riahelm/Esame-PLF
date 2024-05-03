module Coppia where
    {-  Tipo di dato che rappresenta una coppia di elementi uguali -}
    type Coppia a = (a,a)
    
    {-  Funzione che prende due coppie dello stesso tipo e restituisce la coppia risultante dalla somma rispettiva degli elementi -}
    sommaCoppia :: (Num a) => Coppia a -> Coppia a -> Coppia a
    sommaCoppia (a1,b1) (a2,b2) = (a1+a2, b1+b2)
    
    {-  Funzione che prende una coppia e un valore numerico per poi restituire la coppia risultante dalla somma rispettiva di ogni
        elemento della coppia per il valore numerico -}
    moltiplicaCoppiaPerScalare :: (Num a) => Coppia a -> a -> Coppia a
    moltiplicaCoppiaPerScalare (a1,b1) b = (a1*b, b1*b)