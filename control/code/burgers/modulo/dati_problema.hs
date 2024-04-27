module Parametri where

{- Parametri in ingresso per la risoluzione dell'equazione di Burgers a una dimensione -}

lmtSup :: Double
lmtSup = 2.0 * pi                           {- limite superiore del dominio spaziale -}
lmtInf :: Double
lmtInf = 0.0                                {- limite inferiore del dominio spaziale -}  
nx :: Int
nx = 201                                    {- numero di punti della griglia spaziale -} 
t0 :: Double
t0 = 0.0                                    {- tempo iniziale di di simulazione -}
tFine :: Double
tFine = 0.6                                 {- tempo totale di simulazione -}
dx :: Double
dx = lmtSup / (fromIntegral(nx :: Int) - 1) {- distanza tra qualsiasi coppia di punti della griglia adiacenti -}
nu :: Double
nu = 0.07                                   {- coefficiente di diffusione -}
sigma :: Double                                            
sigma = 0.1                                 {- costante di Courant-Friedrichs_Lewy (CFL) -} 
dt :: Double
dt = sigma * dx**2 / nu                     {- lunghezza del passo temporale -}
nt :: Int 
nt = truncate(tFine / dt)                   {- numero complessivo di passi temporali che deve effettuare l'algoritmo -}

