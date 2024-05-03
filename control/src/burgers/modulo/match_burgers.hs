module MatchBurgers(main_burgers) where

type Dati a = (a,a,a)


main_burgers :: Int -> [Double]
main_burgers nx = calcConvTempo (condizioneIniziale nx lmtInf lmtSup) nt condBordoInf (nu, dx, dt) 
                                                                         condBordoSup (nu, dx, dt)
                                                                         passoEulero  (nu, dx, dt) lx i
                     where
                       lmtInf = 0.0                                -- limite inferiore del dominio spaziale 
                       lmtSup = 2.0 * pi                           -- limite superiore del dominio spaziale 
                       dx = lmtSup / (fromIntegral(nx :: Int) - 1) -- distanza tra qualsiasi coppia di punti della griglia adiacenti 
                       sigma = 0.1                                 -- costante di Courant-Friedrichs_Lewy (CFL)
                       dt = sigma * dx**2 / nu                     -- lunghezza del passo temporale 
                       tFine = 0.6                                 -- tempo totale di simulazione 
                       nt = truncate(tFine / dt)                   -- numero complessivo di passi temporali che deve effettuare l'algoritmo 


calcConvTempo :: [Double] -> Int -> (Dati Double -> Double) -> (Dati Double -> Double) -> (Dati Double -> [Double] -> Int -> Double) -> [Double]
calcConvTempo onda 0 _ _ _ _      = onda
calcConvTempo onda nt  condBordoInf (nu, dx, dt)  condBordoSup (nu, dx, dt) passoEulero (nu, dx, dt) lx i = calcConvTempo (x : calcConvSpazio onda 1 nu dx dt) (nt - 1) nx condBordoInf (nu, dx, dt) condBordoSup (nu, dx, dt) passoEulero (nu, dx, dt) lx i 


condBordoInf :: Dati Double -> Double
condBordoInf (nu, dx, dt) = head onda - head onda * dt/dx * (head onda - last onda) + 
                            nu*dt/dx**2 * ((head $ tail onda) - 2*(head onda) + last onda)
            
condBordoSup :: Dati Double -> Double
condBordoSup (nu, dx, dt)  = (last lx) - (last lx) * dt/dx * ((last lx) - (last $ init lx)) + 
                             nu*dt/dx**2*(head lx - 2*(last lx) + (last $ init lx))

passoEulero :: Dati Double -> [Double] -> Int -> Double
passoEulero (nu, dx, dt) lx i  = (lx !! i - lx !! i * dt/dx * (lx !! i - lx !! (i-1)) + 
                                 nu*dt/dx**2*(lx !! (i+1) - 2*(lx !! i) + lx !! (i-1))) 