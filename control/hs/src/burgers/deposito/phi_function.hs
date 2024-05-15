{-
-- espressione
phiprime = frazio1 - frazio2 

-- prima frazione
frazio1  = -(num1 / denom1)
num1     = fatt1 * fatt2
fatt1    = (-8 * t) + (2 * x)
fatt2    = exp fra
fra      = - (num / denom)
num      = y**2
y        = (-4 * t) + x
denom    = 4 * nu * (t + 1)
denom1   = denom

-- seconda frazione
frazio2  = -(num2 / denom2)
num2     = fatt3 * fatt4
fatt3    = -(8 * t) + (2 * x) - (4 * pi)
fatt4    = exp fra1 
fra1     = -(n / d)
n        = z**2
z        = -(4 * t) + x - (2 * pi)
d        = denom
denom2   = denom

--derivata
u   = -2 * nu (phiprime / phi) + 4
phi = fatt4 + fatt 2

-}

phi      = exp(-(x-4*t)**2/(4*nu*(t+1))) + exp(-(x-4*t-2*pi)**2/(4*nu*(t+1)))
phiprime = -(-8*t + 2*x)*exp(-(-4*t + x)**2/(4*nu*(t + 1)))/(4*nu*(t + 1)) - (-8*t + 2*x - 4*pi)*exp(-(-4*t + x - 2*pi)**2/(4*nu*(t + 1)))/(4*nu*(t + 1))
u = -2*nu*(phiprime/phi)+4

phi1 = -(x-4*t)**2/(4*nu*(t+1))
phi2 = exp(-(x-4*t)**2/(4*nu*(t+1)))
phi3 = exp(-(x-4*t-2*pi)**2/(4*nu*(t+1)))
phi4 = -(x-4*t-2*pi)**2
 
-- variabili
t  = 1
x  = 4
nu = 3
