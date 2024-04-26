import Data.List

main :: IO ()
main = do putStrLn "Inserisci la lunghezza del passo temporale: "
          dt <- getLine 
          putStrLn $ show (calcEulero (z0, b0) (zt, g) ((read dt :: Float) ) 0 nt )

-- mainEuler :: (Num a, Fractional a, Floating a) => [Dati a]
-- mainEuler = calcEulero (1000.0, 10.0) (100, 9.81) 0.1 0 1000 
--zt :: Floating
zt = 100.0 
--g  :: Floating
g  = 9.81
--z0 :: Floating
z0 = 100.0
--b0 :: Floating
b0 = 10.0
--t  :: Floating
t  = 100.0
--nt :: Int
nt = 1000
-----------------------------------------------------------------------------------------------------
         {- let zt = profondita     {- Dato simulazione: profondità al di sotto di una linea orizzonatale di riferimento -}
          let g  = acceleraGravit {- Dato simulazione accelerazione di gravità -}
          let z0 = altitudine     {- Dato aliante: altitudine -}
          let b0 = velocita       {- Dato aliante: velocità ascendente risultante dalla raffica -}
          let t  = tempoVolo      {- Tempo di volo finale -}
          let nt = numPassiTemp   -- t / (read dt :: Float) numero di passi temporali -}


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
