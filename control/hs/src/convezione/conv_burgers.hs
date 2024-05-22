

{- coefficiente di diffusione -}

nu :: Double
nu = 0.07  

{- La funzione main_burgers ... -}

main_burgers :: Int -> [Double]
main_burgers nx = tempo_burg (cond_iniziale nx onda_dente_sega lmt_inf lmt_sup) nt nx nu dx dt
                     where
                       lmt_inf = 0.0                                    -- limite inferiore del dominio spaziale 
                       lmt_sup = 2.0 * pi                               -- limite superiore del dominio spaziale 
                       dx     = lmt_sup / (fromIntegral(nx :: Int) - 1) -- distanza tra qualsiasi coppia di punti della griglia adiacenti 
                       sigma  = 0.1                                     -- costante di Courant-Friedrichs_Lewy (CFL)
                       dt     = sigma * dx**2 / nu                      -- lunghezza del passo temporale 
                       t_fine = 0.6                                     -- tempo totale di simulazione 
                       nt     = floor(t_fine / dt)                      -- numero complessivo di passi temporali che deve effettuare l'algoritmo 

{- La funzione tempo_burg ... -}

tempo_burg :: [Double] -> Int -> Int -> Double -> Double -> Double -> [Double]
tempo_burg onda 0 _ _ _ _      = onda
tempo_burg onda nt nx nu dx dt = tempo_burg (bordo_inf : spazio_burg onda 1 nu dx dt) (nt - 1) nx nu dx dt
                                       where
                                         bordo_inf = head onda - head onda * dt/dx * (head onda - last onda) +
                                                     nu*dt/dx**2 * ((head $ tail onda) - 2*(head onda) + last onda) -- condizione di bordo inferiore

{- La funzione spazio_burg ... -}

spazio_burg :: [Double] -> Int -> Double -> Double -> Double -> [Double]
spazio_burg lx i un dx dt  | i == length lx - 1 = [bordo_sup]
                              | otherwise          = (passo_eulero) : spazio_burg lx (i+1) un dx dt
                                  where
                                    bordo_sup    = (last lx) - (last lx) * dt/dx * ((last lx) - (last $ init lx)) +
                                                   nu*dt/dx**2*(head lx - 2*(last lx) + (last $ init lx))
                                    passo_eulero = (lx !! i - lx !! i * dt/dx * (lx !! i - lx !! (i-1)) + 
                                                   nu*dt/dx**2*(lx !! (i+1) - 2*(lx !! i) + lx !! (i-1)))



{- La funzione onda_dente_sega ... -}

onda_dente_sega :: Double -> Double
onda_dente_sega x = u t0 x nu
                       where
                         t0 = 0.0                                                                              
                         phi_primo t0 x nu = -(-8*t0 + 2*x)*exp(-(-4*t0 + x)**2/(4*nu*(t0 + 1)))/(4*nu*(t0 + 1)) - 
                                             (-8*t0 + 2*x - 4*pi)*exp(-(-4*t0 + x - 2*pi)**2/(4*nu*(t0 + 1)))/(4*nu*(t0 + 1))       
                         phi t0 x nu       = exp(-(x-4*t0)**2/(4*nu*(t0+1))) + exp(-(x-4*t0-2*pi)**2/(4*nu*(t0+1)))
                         u t0 x nu         = -2*nu*((phi_primo t0 x nu) / (phi t0 x nu))+4


{- La funzione calc_convezione calcola l'integrazione numerica
   dell'equazione di convezione lineare a una dimensione. -}

calc_convezione :: Int -> Double -> [Double]
calc_convezione nx dt | nx == 0 || nx == 1    = cond_iniziale nx onda_quadra lmt_inf lmt_sup
                      | otherwise             = tempo_conv nt nx c dx dt (cond_iniziale nx onda_quadra lmt_inf lmt_sup)
                            where
                              lmt_inf = 0.0                                     -- limite inferiore del dominio spaziale 
                              lmt_sup = 2.0                                     -- limite superiore del dominio spaziale
                              nt      = 25                                      -- numero complessivo di passi temporali che deve effettuare l'algoritmo 
                              dx      = lmt_sup / (fromIntegral(nx :: Int) - 1) -- distanza tra qualsiasi coppia di punti della griglia adiacenti 
                              c       = 1.0                                     -- velocità dell'onda 

{- La funzione tempo_conv calcola numericamente l'integrale della
   funzione rispetto al parametro temporale dt:
   - il primo argomento e' il numero di passi temporali totali che la
     funzione d'onda deve compiere; 
   - il secondo argomento e' il numero di passi spaziali utilizzati dal
     predicato conv_spazio;
   - il terzo argomento e' la costante di velocità dell'onda;     
   - il quarto argomento e' la lunghezza del passo spaziale;
   - il quinto argomento e' la lunghezza del passo temporale;
   - il sesto argomento e' la funzione d'onda ricalcolata;
   - l' settimo argomento e' la funzione d'onda risultante.  -}

tempo_conv :: Int -> Int -> Double -> Double -> Double -> [Double] -> [Double]
tempo_conv 0 _ _ _ _ onda     = onda
tempo_conv nt nx c dx dt onda = tempo_conv (nt - 1) nx c dx dt ((head onda) : spazio_conv 1 c dx dt onda) 


{- La funzione spazio_conv calcola numericamente l'integrale della
   funzione rispetto al parametro spaziale dx:
   - il primo argomento e' il numero di passi temporali che la funzione
     d'onda ha compiuto;
   - il secondo argomento e' la costante di velocità dell'onda;      
   - il terzo argomento e' la lunghezza del passo spaziale;
   - il quarto argomento e' la lunghezza del passo temporale;
   - il quinto argomento e' la funzione d'onda;
   - il sesto argomento e' la funzione d'onda ricalcolata con il passo_
     eulero  -}

spazio_conv :: Int -> Double -> Double -> Double -> [Double] -> [Double] 
spazio_conv i c dx dt lx  | i == length lx - 1 = [passo_eulero]
                          | otherwise          = (passo_eulero) : spazio_conv (i+1) c dx dt lx
                                where
                                  passo_eulero =  lx !! i - c * dt /dx *(lx !! i - lx !! (i-1))




{- La funzione cond_iniziale calcola la condizione iniziale (una funzione)
   per l'integrazione numerica dell'equazione di convezione e di Burgers:
   - il primo argomento e' il numero di punti della griglia spaziale;
   - il secondo argomento e' la funzione onda_quadra (onda_dente_sega) 
     utilizzata per il calcolo delle omonime funzioni;
   - il terzo argomento e' il limite inferiore del dominio spaziale;
   - il quarto argomento e' il limite superiore del dominio spaziale; 
   - il quinto argomento e' la funzione d'onda quadra (o a dente di
     sega) calcolata. -}

cond_iniziale :: Int -> (Double -> Double) -> Double -> Double -> [Double]
cond_iniziale nx onda lmt_inf lmt_sup = [onda x | x <- lx]
        where
          lx = gen_punti_equi nx lmt_inf lmt_sup


{- La funzione onda_quadra calcola la funzione d'onda quadra:
   - il primo argomento e' la lista di punti equidistanti del dominio
     spaziale;
   - il secondo argomento e' la funzione d'onda calcolata. -}

onda_quadra :: Double -> Double
onda_quadra x | x >= 0.5 && x <= 1.0 = onda_sup
              | otherwise            = onda_inf
                     where
                       onda_sup = 2.0 -- valori assunti dalla parte alta della funzione d'onda quadra
                       onda_inf = 1.0 -- valori assunti dalla parte bassa della funzione d'onda quadra



{- La funzione gen_punti_equi genera una lista di punti equidistanti tra loro:
   - il primo argomento e' il numero di punti che si vuole generare;
   - il secondo argomento e' il limite inferiore della lista di punti;
   - il terzo argomento e' il limite superiore della lista di punti;
   - il quarto argomento e' la lista di punti equidistanti.
   Per il calcolo dei punti si fa uso della funzione calc_punti. -}

gen_punti_equi :: Int -> Double -> Double -> [Double]
gen_punti_equi 0 _ _      = []
gen_punti_equi nx inf sup = calc_punti 0 (nx - 1) inf (sup  - inf)

{- La funzione calc_punti ... -}

calc_punti :: Int -> Int -> Double -> Double -> [Double]
calc_punti i nx inf dst | i == nx   = [inf]
                        | otherwise = inf : calc_punti (i + 1) nx (inf + (dst / fromIntegral(nx :: Int))) dst


