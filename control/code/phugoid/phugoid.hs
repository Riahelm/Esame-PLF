import Data.List
type Dati a = (a,a,a,a)

estrai :: [Dati a] -> Int -> Dati a
estrai (x:xs) 0 = x
estrai (_:xs) i = estrai xs (i-1)

linspace :: Int -> Double -> Double -> Double -> [Double]
linspace i low up pts | i >= 0    = low : linspace (i - 1) (low + (up / pts)) up pts
                      | otherwise = []

sommaTupla :: (Num a) => Dati a -> Dati a -> Dati a
sommaTupla (a1,b1,c1,d1) (a2,b2,c2,d2) = (a1+a2, b1+b2, c1+c2, d1+d2)

moltiplicaTupla :: (Num a) => Dati a -> Dati a -> Dati a
moltiplicaTupla (a1,b1,c1,d1) (a2,b2,c2,d2) = (a1*a2, b1*b2, c1*c2, d1*d2)

moltiplicaTuplaPerScalare :: (Num a) => Dati a -> a -> Dati a
moltiplicaTuplaPerScalare (a1,b1,c1,d1) b = (a1*b, b1*b, c1*b, d1*b)

rhs :: (Num a, Floating a) => Dati a -> Dati a-> Dati a
rhs (v,theta,x,y) (cG@costGrav, vT@vTrim, cR@coeffResist, cP@coeffPort) =(- (cG * sin theta) - (cR / cP)*cG/vT**2*v**2,
                                                                         - (cG * cos theta / v) + cG/vT**2*v,
                                                                         v*cos theta,
                                                                         v*sin theta)

metodoEulero :: (Num a, Floating a) => Dati a -> Dati a -> a -> Dati a
metodoEulero dA@datiAliante dS@datiSimulazione dt = sommaTupla dA (moltiplicaTuplaPerScalare (rhs dA dS) dt)

calcEulero :: (Num a, Floating a) => Dati a -> Dati a -> a -> Int -> Int -> [a]
calcEulero dA@(dAA,_,_,_) dS@datiSimulazione dt i len| i == 0            = dAA : calcolaProssimoPunto
                                                     | i == (len - 1)    = [dBA]
                                                     | otherwise         = dBA : calcolaProssimoPunto
                                                     where
                                                        dB@(dBA,_,_,_) = metodoEulero dA dS dt 
                                                        calcolaProssimoPunto = calcEulero dB dS dt (i+1) len

mainEuler :: (Num a, Fractional a, Floating a) => [a]
mainEuler = calcEulero (30.0, 0.0, 0.0, 1000.0) (9.81, 30.0, 0.05, 1.0) 0.1 0 1000 