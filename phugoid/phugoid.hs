type Dati a = (a,a,a,a)
--type Dati = (Floating a,Floating b,Floating c,Floating d)

lunghezza :: [a] -> Int
lunghezza []        = 0
lunghezza (x:xs)    = 1 + lunghezza xs

estrai :: [Dati a] -> Int -> Dati a
estrai (x:xs) 0 = x
estrai (_:xs) i = estrai xs (i-1)

linspace :: Int -> Double -> Double -> Double -> [Double]
linspace i low up pts | i >= 0    = low : linspace (i - 1) (low + (up / pts)) up pts
                      | otherwise = []

respecSum :: (Num a) => Dati a -> Dati a -> Dati a
respecSum (a1,b1,c1,d1) (a2,b2,c2,d2) = (a1+a2, b1+b2, c1+c2, d1+d2)

respecMul :: (Num a) => Dati a -> Dati a -> Dati a
respecMul (a1,b1,c1,d1) (a2,b2,c2,d2) = (a1*a2, b1*b2, c1*c2, d1*d2)

scalarMul :: (Num a) => Dati a -> a -> Dati a
scalarMul (a1,b1,c1,d1) b = (a1*b, b1*b, c1*b, d1*b)

rhs :: (Num a, Floating a) => Dati a -> Dati a
rhs (v,theta,x,y) =(- (9.81 * sin theta) - (1 / 40)*9.81/30.0**2*v**2,
                    - (9.81 * cos theta / v) + 9.81/30.0**2*v,
                       v*cos theta,
                       v*sin theta)

eulerStep :: (Num a, Floating a) => Dati a -> a -> Dati a
eulerStep datum dt = respecSum datum (scalarMul (rhs datum) dt)

forloop :: (Num a, Floating a) => Dati a -> a -> Int -> Int -> [Dati a]
forloop datum dt i len  | i == 0 = datum : forloop datum dt (i+1) len 
                        | i == (len - 1) = [datum2]
                        | otherwise = datum2 : forloop datum2 dt (i+1) len
                        where
                            datum2 = eulerStep datum dt 

mainEuler :: (Num a, Fractional a, Floating a) => [Dati a]
mainEuler = forloop (30.0, 0.0, 0.0, 1000.0) 0.1 0 1000 
--Change for loop, change all the constraints