
-- creare la griglia di punti mediante la funzione linspace()

-- var:
-- low = 0
-- up  = 2*pi 
-- nx  = 201

linspace :: Int -> Double -> Double -> Double -> [Double]
linspace i low up pts | i >= 0    = low : linspace (i - 1) (low + (up / pts)) up pts 
                      | otherwise = []

-- disegnare la funzione 

-- var
-- t  = 1
-- nu = 3
-- x = ...per ogni valore di linspace() = lx

phiprime :: Double -> Double -> Double -> Double 
phiprime t x nu = -(-8*t + 2*x)*exp(-(-4*t + x)**2/(4*nu*(t + 1)))/(4*nu*(t + 1)) - (-8*t + 2*x - 4*pi)*exp(-(-4*t + x - 2*pi)**2/(4*nu*(t + 1)))/(4*nu*(t + 1))

phi :: Double -> Double -> Double -> Double 
phi t x nu = exp(-(x-4*t)**2/(4*nu*(t+1))) + exp(-(x-4*t-2*pi)**2/(4*nu*(t+1)))

u :: Double -> Double -> Double -> Double 
u  t x nu = -2*nu*(phiprime(t x nu) / phi(t x nu))+4

wave :: [Double] -> [Double]
wave lx = [u t x nu | x <- lx]

main_calculate = wave(linspace 201 0 6.28 201) 