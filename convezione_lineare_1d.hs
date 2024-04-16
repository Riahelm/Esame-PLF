
{-main :: IO()
main = do
    putStrLn "LE ISTRUZIONI VANNO QUI"

    let nx = 41
    let nt = 25
    let c = 1.0
    let dx = 0.05 --cambia TRAMITE let dx = div 2. (nx - 1)
    let dt = 0.02
    let onda = [1,1,1,1,1,1,1,2,2,2,2,2,2,1,1,1,1,1,1,1,1]
    let valori_finali = calcConvezione onda nx nt c dx dt

    print valori_finali-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use foldr" #-}

calcConvezione :: [Double] -> Int -> Int -> Double -> Double -> Double -> [Double]
calcConvezione onda 0 _ _ _ _     = onda
calcConvezione onda nx nt c dx dt = calcConvezione (calcolaVett onda 1 c dx dt) nx (nt - 1) c dx dt

lunghezza :: [a] -> Int
lunghezza []        = 0
lunghezza (x:xs)    = 1 + lunghezza xs

estrai :: [Double] -> Int -> Double
estrai (x:xs) 0 = x
estrai (_:xs) i = estrai xs (i-1)

uni :: (Num a, Ord a) => a -> [Int]
uni a   | a < 1     = []
        | otherwise = 1 : uni (a - 1)

{-calcolaVett :: [Double] -> [Double] -> Int -> Double -> Double -> Double -> [Double]
calcolaVett onda _ 1 _ _ _        = onda
calcolaVett lx@(x:_) (_:ys) nx c dx dt  | nx == lunghezza lx = x : calcolaVett lx ys (nx - 1) c dx dt 
                                        | otherwise          = estrai lx (6 - (nx - 1)) - c * dt /dx *estrai lx (6 - (nx - 1)) - estrai lx (6 - nx) : calcolaVett lx ys (nx - 1) c dx dt
-}
calcolaVett :: [Double] -> Int -> Double -> Double -> Double -> [Double]
calcolaVett lx@(x:_) i c dx dt  | i == 0                = x : calcolaVett lx (i+1) c dx dt
                                | i == lunghezza lx - 1 = [estrai lx i - c * dt /dx *(estrai lx i - estrai lx (i-1))]
                                | otherwise             = (estrai lx i - c * dt /dx *(estrai lx i - estrai lx (i-1))) : calcolaVett lx (i+1) c dx dt



--calcolaVett [1,1,2,2,1,1] [1,1,2,2,1,1] 6 1.0 0.05 0.02 
--calcolaVett [1,1,2,2,1,1] 0 1.0 0.05 0.02 
