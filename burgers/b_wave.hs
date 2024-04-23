
-- funzioni per operare sulle liste

lunghezza :: [a] -> Int
lunghezza []        = 0
lunghezza (x:xs)    = 1 + lunghezza xs

estrai :: [Double] -> Int -> Double
estrai (x:xs) 0 = x
estrai (_:xs) i = estrai xs (i-1)

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
-- t  = 0
-- nu = 0.07  
-- x = ...per ogni valore di linspace() = lx

phiprime :: Double -> Double -> Double -> Double 
phiprime t x nu = -(-8*t + 2*x)*exp(-(-4*t + x)**2/(4*nu*(t + 1)))/(4*nu*(t + 1)) - (-8*t + 2*x - 4*pi)*exp(-(-4*t + x - 2*pi)**2/(4*nu*(t + 1)))/(4*nu*(t + 1))

phi :: Double -> Double -> Double -> Double 
phi t x nu = exp(-(x-4*t)**2/(4*nu*(t+1))) + exp(-(x-4*t-2*pi)**2/(4*nu*(t+1)))

u :: Double -> Double -> Double -> Double 
u t x nu = -2*nu*((phiprime t x nu) / (phi t x nu))+4

-- funzione con condizione iniziale al tempo t0 = 0  
wave :: [Double] -> Double -> Double -> [Double]
wave lx t nu = [u t x nu | x <- lx]

main_calculate = wave (linspace 201 0 6.28 201) 0 0.07 

-- var:
-- T     = 0.6
-- dx    = 2*pi/(nx-1)     = 0.0314
-- sigma = .1
-- dt    = sigma*dx**2/nu  = 0.0014
-- nt    = int(T/dt)       = 425

calcolaVett :: [Double] -> Int -> Double -> Double -> Double -> [Double]
calcolaVett lx i nu dx dt  | i == 0                = (estrai lx i) - (estrai lx i) * dt/dx * ((estrai lx i) - (estrai lx (lunghezza lx - 1))) + nu*dt/dx**2 * ((estrai lx (i+1)) - 2*(estrai lx i) + (estrai lx (lunghezza lx - 1))) 
                                                     : calcolaVett lx (i+1) nu dx dt
                           | i == lunghezza lx - 1 = [(estrai lx (lunghezza lx - 1)) - (estrai lx (lunghezza lx - 1)) * dt/dx * ((estrai lx (lunghezza lx - 1)) - (estrai lx (lunghezza lx - 2))) + nu*dt/dx**2*((estrai lx 0) - 2*(estrai lx (lunghezza lx - 1)) + (estrai lx (lunghezza lx - 2)))]                    
                           | otherwise             = ((estrai lx i)  - (estrai lx i) * dt/dx * ((estrai lx i) - (estrai lx (i-1))) + nu*dt/dx**2*((estrai lx (i+1)) - 2*(estrai lx i) + (estrai lx (i-1)))) 
                                                     : calcolaVett lx (i+1) nu dx dt


-- boundary
-- un[0]        - un[0]        * dt/dx * (un[0]        - un[-1])                   + nu*dt/dx**2* (un[1]           - 2*un[0]         + un[-1])
-- estrai lx i  - estrai lx i  * dt/dx * (estrai lx i  - estrai lx (lunghezza lx)) + nu*dt/dx**2* (estrai lx (i+1) - 2*(estrai lx i) + estrai lx (lunghezza lx))

-- un[-1]                   - un[-1]                   * dt/dx * (un[-1]                   - un[-2])                       + nu*dt/dx**2*(un[0]       - 2*un[-1]                     + un[-2])
-- estrai lx (lunghezza lx) - estrai lx (lunghezza lx) * dt/dx * (estrai lx (lunghezza lx) - estrai lx (lunghezza lx - 1)) + nu*dt/dx**2*(estrai lx 0 - 2*(estrai lx (lunghezza lx)) + estrai lx (lunghezza lx - 1))

--bulk
-- un[1:-1]     - un[1:-1]    * dt/dx * (un[1:-1]    - un[:-2])         + nu*dt/dx**2*(un[2:]          - 2*un[1:-1]      + un[:-2])
-- estrai lx i  - estrai lx i * dt/dx * (estrai lx i - estrai lx (i-1)) + nu*dt/dx**2*(estrai lx (i+1) - 2*(estrai lx i) + estrai lx (i-1))

-- test su calcolaVett
second_calculate = calcolaVett (wave (linspace 201 0 6.28 201) 0 0.07 ) 0 0.07 0.0314 0.0014 

calcBurgers :: [Double] -> Int -> Int -> Double -> Double -> Double -> [Double]
calcBurgers onda _ 0 _ _ _      = onda
calcBurgers onda nx nt nu dx dt = calcBurgers (calcolaVett onda 0 nu dx dt) nx (nt - 1) nu dx dt


-- test su calcBurgers
third_calculate = calcBurgers (wave (linspace 201 0 6.28 201) 0 0.07) 201 425 0.07 0.0314 0.0014

