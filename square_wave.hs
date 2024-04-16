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

linspace :: [Double] -> Int -> Int -> Int -> [Double]
linspace low up dis | low == 0            = low : linspace low dis pts - 1
                    | pts > 0 && dis != 0 = (low + dis) : linspace (low + dis) dis pts - 1
                    | otherwise           = []
                    