module Funzionalita (Dati, sommaTupla, moltiplicaTuplaPerScalare)where

    type Dati a = (a,a,a,a)

    sommaTupla :: (Num a) => Dati a -> Dati a -> Dati a
    sommaTupla (a1,b1,c1,d1) (a2,b2,c2,d2) = (a1+a2, b1+b2, c1+c2, d1+d2)

    moltiplicaTuplaPerScalare :: (Num a) => Dati a -> a -> Dati a
    moltiplicaTuplaPerScalare (a1,b1,c1,d1) b = (a1*b, b1*b, c1*b, d1*b)