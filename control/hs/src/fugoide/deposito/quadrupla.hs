module Quadrupla where
    {-  Tipo di dato che rappresenta una quadrupla di elementi uguali -}
    type Quadrupla a = (a,a,a,a)

    {-  Funzione che prende due coppie dello stesso tipo e restituisce la quadrupla risultante dalla somma rispettiva degli elementi -}
    sommaQuadrupla :: (Num a) => Quadrupla a -> Quadrupla a -> Quadrupla a
    sommaQuadrupla (a1,b1,c1,d1) (a2,b2,c2,d2) = (a1+a2, b1+b2, c1+c2, d1+d2)

    {-  Funzione che prende una quadrupla e un valore numerico per poi restituire la quadrupla risultante dalla somma rispettiva di ogni
        elemento della quadrupla per il valore numerico -}
    moltiplicaQuadruplaPerScalare :: (Num a) => Quadrupla a -> a -> Quadrupla a
    moltiplicaQuadruplaPerScalare (a1,b1,c1,d1) b = (a1*b, b1*b, c1*b, d1*b)