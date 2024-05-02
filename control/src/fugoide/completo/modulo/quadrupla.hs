module Quadrupla where

    type Quadrupla a = (a,a,a,a)

    sommaQuadrupla :: (Num a) => Quadrupla a -> Quadrupla a -> Quadrupla a
    sommaQuadrupla (a1,b1,c1,d1) (a2,b2,c2,d2) = (a1+a2, b1+b2, c1+c2, d1+d2)

    moltiplicaQuadruplaPerScalare :: (Num a) => Quadrupla a -> a -> Quadrupla a
    moltiplicaQuadruplaPerScalare (a1,b1,c1,d1) b = (a1*b, b1*b, c1*b, d1*b)