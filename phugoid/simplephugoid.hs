import Data.List
type Dati a = (a,a)

sommaTupla :: (Num a) => Dati a -> Dati a -> Dati a
sommaTupla (a1,b1) (a2,b2) = (a1+a2, b1+b2)

moltiplicaTupla :: (Num a) => Dati a -> Dati a -> Dati a
moltiplicaTupla (a1,b1) (a2,b2) = (a1*a2, b1*b2)

moltiplicaTuplaPerScalare :: (Num a) => Dati a -> a -> Dati a
moltiplicaTuplaPerScalare (a1,b1) b = (a1*b, b1*b)

rhs :: (Num a, Floating a) => Dati a -> Dati a-> Dati a
rhs (y@altitude, v@velocity) (cG@costGrav, zt) = (v,cG * (1-y/zt))

metodoEulero :: (Num a, Floating a) => Dati a -> Dati a -> a -> Dati a
metodoEulero dA@datiAliante dS@datiSimulazione dt = sommaTupla dA (moltiplicaTuplaPerScalare (rhs dA dS) dt)

calcEulero :: (Num a, Floating a) => Dati a -> Dati a -> a -> Int -> Int -> [a]
calcEulero dA@(dAA,_) dS@datiSimulazione dt i len   | i == (len - 1)    = [dBA]
                                                    | otherwise         = dBA : calcolaProssimoPunto
                                                    where
                                                        dB@(dBA,_) = metodoEulero dA dS dt
                                                        calcolaProssimoPunto = calcEulero dB dS dt (i+1) len


mainEuler :: (Num a, Fractional a, Floating a) => [a]
mainEuler = 100.0 : calcEulero (100.0, 10.0) (9.81, 100) 0.01 1 10000