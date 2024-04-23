

estrai :: [Double] -> Int -> Double
estrai (x:xs) 1 = x
estrai (_:xs) i = estrai xs (i-1)

calcolaVett :: [Double] -> [Double] -> Int -> Double -> Double -> Double -> [Double]
calcolaVett onda _ 1 _ _ _        = onda
calcolaVett lx@(x:xs) ly@(y:ys) nx c dx dt = [estrai lx 2 - (c * dt /dx *(estrai lx 2 - estrai lx 1))] ++ calcolaVett xs ys (nx - 1) c dx dt
