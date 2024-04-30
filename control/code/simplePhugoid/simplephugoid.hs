module FugoideSemplice(mainFugoide) where
type Dati a = (a,a)

mainFugoide :: (Num a, Fractional a, Floating a) => a -> [a]
mainFugoide dt = 100.0 : calcMoto (100.0, 10.0) (9.81, 100) dt 10000

calcMoto :: (Num a, Floating a) => Dati a -> Dati a -> a -> Int -> [a]
calcMoto dA dS dt 0 = [dBA]
                        where 
                            (dBA,_) = metodoEulero dA dS dt
calcMoto dA dS dt len = dBA : calcolaProssimoPunto
                                            where
                                                dB@(dBA,_)              = metodoEulero dA dS dt
                                                calcolaProssimoPunto    = calcMoto dB dS dt (len - 1)



metodoEulero :: (Num a, Floating a) => Dati a -> Dati a -> a -> Dati a
metodoEulero dA@datiAliante dS@datiSimulazione dt = sommaTupla dA (moltiplicaTuplaPerScalare (rhs dA dS) dt)

rhs :: (Num a, Floating a) => Dati a -> Dati a-> Dati a
rhs (y@altitudine, v@velocita) (cG@costGrav, zt) = (v,cG * (1-y/zt))

sommaTupla :: (Num a) => Dati a -> Dati a -> Dati a
sommaTupla (a1,b1) (a2,b2) = (a1+a2, b1+b2)

moltiplicaTuplaPerScalare :: (Num a) => Dati a -> a -> Dati a
moltiplicaTuplaPerScalare (a1,b1) b = (a1*b, b1*b)