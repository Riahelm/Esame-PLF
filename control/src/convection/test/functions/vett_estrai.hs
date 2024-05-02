
-- estrai :: [Double] -> Int -> Double
estrai (x:xs) 1 = x
estrai (_:xs) i = estrai xs (i-1)

vett :: [Int] -> Int -> [Int]
vett list 1      = list
vett lx@(x:xs) n = [estrai lx 1 + estrai lx 2] ++ vett xs (n - 1) 
