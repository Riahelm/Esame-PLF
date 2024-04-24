
lunghezza :: [a] -> Int
lunghezza []        = 0
lunghezza (x:xs)    = 1 + lunghezza xs

estrai :: [Double] -> Int -> Double
estrai (x:xs) 0 = x
estrai (_:xs) i = estrai xs (i-1)

rimuovi_elem :: [Double] -> Int -> Int -> [Double]
rimuovi_elem [] _ _                 = []
rimuovi_elem (x:xs) i k | i = k     = rimuovi_elem xs (i + 1)
                        | otherwise = x : rimuovi_elem xs (i + 1) 


linspace :: Int -> Double -> Double -> Double -> [Double]
linspace i low up pts | i >= 0    = low : linspace (i - 1) (low + (up / pts)) up pts 
                      | otherwise = []
                
wave :: [Double] -> [Double]
wave  []                                                   = []
wave  lx@(x:xs) | lunghezza lx > 0 && x >= 0.5 && x <= 1.0 = 2 : wave xs
                | otherwise                                = 1 : wave xs   
        
--calcolaVett :: [Double] -> Int -> Double -> Double -> Double -> [Double]
--calcolaVett lx@(x:_) i c dx dt  | i == 0                = x : calcolaVett lx (i+1) c dx dt
--                                | i == lunghezza lx - 1 = [estrai lx i - c * dt /dx *(estrai lx i - estrai lx (i-1))]
--                                | otherwise             = (estrai lx i - c * dt /dx *(estrai lx i - estrai lx (i-1))) : calcolaVett lx (i+1) c dx dt

calcolaVett :: [Double] -> Int -> Double -> Double -> Double -> [Double]
calcolaVett lx@(x:_) nx c dx dt = x : [oneStep x dx dt z y | z <- rimuovi_elem 0, y <- rimuovi_elem (nx - 1)]
       where 
          oneStep x dx dt z y = z - c * dt/dx * (z - y)


calcConvezione :: [Double] -> Int -> Int -> Double -> Double -> Double -> [Double]
calcConvezione onda _ 0 _ _ _     = onda
calcConvezione onda nx nt c dx dt = calcConvezione (calcolaVett onda nx c dx dt) nx (nt - 1) c dx dt

--  nx = 41
--  nt = 25
--  c = 1.0
--  dx = 0.05 --cambia TRAMITE let dx = div 2. (nx - 1)
--  dt = 0.02

main_calculate :: [Double]
main_calculate = calcConvezione (wave (linspace 41 0 2 41 )) 41 25 1.0 0.05 0.02
