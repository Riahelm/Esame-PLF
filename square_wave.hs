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
