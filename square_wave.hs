-- Creazione di un onda quadra

-- 1. Funzione per la creazione di una lista di punti equidistanti
--    fra loro (numpy.linspace()).

{- var:
   list     = []
   lower    = 0
   upper    = 2
   points   = 41
   distance = upper / points
-}

linspace :: Int -> Double -> Double -> Double -> [Double]
linspace i low up pts | i >= 0    = low : linspace (i - 1) (low + (up / pts)) up pts 
                      | otherwise = []

-- 2. Funzione per la creazione dell'onda quadra

{- var:
   list = ...lista di punti equidistanti

-}

lunghezza :: [a] -> Int
lunghezza []        = 0
lunghezza (x:xs)    = 1 + lunghezza xs

estrai :: [Double] -> Int -> Double
estrai (x:xs) 0 = x
estrai (_:xs) i = estrai xs (i-1)

wave :: [Double] -> [Int]
wave  []                                                   = []
wave  lx@(x:xs) | lunghezza lx > 0 && x >= 0.5 && x <= 1.0 = 2 : wave xs
                | otherwise                                = 1 : wave xs   


calc :: [Int]
calc = wave linspace 41 0 2 41  