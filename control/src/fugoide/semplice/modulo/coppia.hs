module Coppia (Coppia, sommaCoppia, moltiplicaCoppiaPerScalare) where
    
    type Coppia a = (a,a)
    
    sommaCoppia :: (Num a) => Coppia a -> Coppia a -> Coppia a
    sommaCoppia (a1,b1) (a2,b2) = (a1+a2, b1+b2)

    moltiplicaCoppiaPerScalare :: (Num a) => Coppia a -> a -> Coppia a
    moltiplicaCoppiaPerScalare (a1,b1) b = (a1*b, b1*b)