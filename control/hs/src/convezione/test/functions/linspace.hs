import Data.List

calcPuntiEqui :: Int -> Int -> Double -> Double -> [Double]
calcPuntiEqui i nx inf sup | i == nx   = []
                           | sup > inf = calcPunti i (nx - 1) inf (abs $ sup - inf) 
			   | otherwise = reverse(calcPunti i (nx - 1) sup (abs $ sup - inf))

calcPunti :: Int -> Int -> Double -> Double -> [Double]
calcPunti i nx inf dst | i == nx   = [inf]
                       | otherwise = inf : calcPunti (i + 1) nx (inf + (dst / fromIntegral(nx :: Int))) dst
