lunghezza :: [a] -> Int
lunghezza []        = 0
lunghezza (x:xs)    = 1 + lunghezza xs

estrai :: [Double] -> Int -> Double
estrai (x:xs) 0 = x
estrai (_:xs) i = estrai xs (i-1)

linspace :: Int -> Double -> Double -> Double -> [Double]
linspace i low up pts | i >= 0    = low : linspace (i - 1) (low + (up / pts)) up pts 
                      | otherwise = []

phiprime :: Double -> Double -> Double -> Double 
phiprime t x nu = -(-8*t + 2*x)*exp(-(-4*t + x)**2/(4*nu*(t + 1)))/(4*nu*(t + 1)) - (-8*t + 2*x - 4*pi)*exp(-(-4*t + x - 2*pi)**2/(4*nu*(t + 1)))/(4*nu*(t + 1))

phi :: Double -> Double -> Double -> Double 
phi t x nu = exp(-(x-4*t)**2/(4*nu*(t+1))) + exp(-(x-4*t-2*pi)**2/(4*nu*(t+1)))

u :: Double -> Double -> Double -> Double 
u t x nu = -2*nu*((phiprime t x nu) / (phi t x nu))+4

-- funzione con condizione iniziale al tempo t0 = 0  
wave :: [Double] -> Double -> Double -> [Double]
wave lx t nu = [u t x nu | x <- lx]

main_calculate = wave (linspace 201 0.5992259814947111 6.28 201) 0 0.07 