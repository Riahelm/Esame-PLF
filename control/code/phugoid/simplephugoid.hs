import Data.List
type Dati a = (a,a)

estrai :: [Dati a] -> Int -> Dati a
estrai (x:xs) 0 = x
estrai (_:xs) i = estrai xs (i-1)

linspace :: Int -> Double -> Double -> Double -> [Double]
linspace i low up pts | i >= 0    = low : linspace (i - 1) (low + (up / pts)) up pts
                      | otherwise = []

sommaTupla :: (Num a) => Dati a -> Dati a -> Dati a
sommaTupla (a1,b1) (a2,b2) = (a1+a2, b1+b2)

moltiplicaTupla :: (Num a) => Dati a -> Dati a -> Dati a
moltiplicaTupla (a1,b1) (a2,b2) = (a1*a2, b1*b2)

moltiplicaTuplaPerScalare :: (Num a) => Dati a -> a -> Dati a
moltiplicaTuplaPerScalare (a1,b1) b = (a1*b, b1*b)

rhs :: (Num a, Floating a) => Dati a -> Dati a-> Dati a
rhs (y@altitude, v@velocity) (cG@costGrav, zt) =(v,cG * (1-y/zt))

metodoEulero :: (Num a, Floating a) => Dati a -> Dati a -> a -> Dati a
metodoEulero dA@datiAliante dS@datiSimulazione dt = sommaTupla dA (moltiplicaTuplaPerScalare (rhs dA dS) dt)

calcEulero :: (Num a, Floating a) => Dati a -> Dati a -> a -> Int -> Int -> [Dati a]
calcEulero dA@datiAliante dS@datiSimulazione dt i len   | i == 0            = dA : calcolaProssimoPunto
                                                        | i == (len - 1)    = [dA2]
                                                        | otherwise         = dA : calcolaProssimoPunto
                                                        where
                                                            dA2 = metodoEulero dA dS dt 
                                                            calcolaProssimoPunto = calcEulero dA2 dS dt (i+1) len

mainEuler :: (Num a, Fractional a, Floating a) => [Dati a]
mainEuler = calcEulero (100.0, 10.0) (100, 9.81) 0.1 0 1000 
