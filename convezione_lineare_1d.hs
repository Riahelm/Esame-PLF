
main :: IO()
main = do
    putStrLn "LE ISTRUZIONI VANNO QUI"

    let nx = 41
    let nt = 25
    let c = 1.0
    let dx = 0.05 --cambia TRAMITE let dx = div 2. (nx - 1)
    let dt = 0.02
    let onda = [1,1,1,1,1,1,1,2,2,2,2,2,2,1,1,1,1,1,1,1,1]
    let valori_finali = calcConvezione onda nx nt c dx dt

    print valori_finali

calcConvezione :: [Double] -> Int -> Int -> Double -> Double -> Double -> [Double]
calcConvezione onda 0 _ _ _ _ = onda
calcConvezione onda nx nt c dx dt = calcConvezione (calcolaVett onda onda nx c dx dt) nx (nt - 1) c dx dt

lunghezza :: [a] -> Int
lunghezza []            = 0
lunghezza (x:xs)        = 1 + length xs

estrai :: [Double] -> Int -> Double
estrai (x:xs) 1 = x
estrai (_:xs) i = estrai xs (i-1)

calcolaVett :: [Double] -> [Double] -> Int -> Double -> Double -> Double -> [Double]
calcolaVett onda _ 0 _ _ _        = onda
calcolaVett lx@(x:xs) ly@(y:ys) nx c dx dt = (estrai lx 2 - (c * dt /dx *(estrai lx 2 - estrai lx 1))) : calcolaVett xs ys (nx - 1) c dx dt
