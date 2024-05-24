module Main where

import Data.List {- necessario per usare: 
                    - !!,     che estrae l'n-esimo elemento di una lista;
                    - head,   che estrae il primo elemento di una lista;
                    - last,   che estrae l'ultimo elemento di una lista; 
                    - tail,   che estrae gli elementi di una lista successivi al primo;
                    - init,   che estrae gli elementi di una lista precedenti all'ultimo;
                    - length, che ritorna la lunghezza della lista. -}


main::IO()
main = do 
          putStrLn "Progetto della sessione estiva del corso Programmazione Logica e Funzionale   "
          putStrLn "Anno 2023/2024                                                                "
          putStrLn "Corso tenuto dal prof. Marco Bernardo                                         "
          putStrLn "Progetto realizzato da: Barzotti Nicolas e Ramagnano Gabriele                 "
          putStrLn "--------------------------------------------------------------------"
          putStrLn "| Calcolo del moto fugoide senza attrito                           |"
          putStrLn "| Parametri iniziali:                                              |"
          putStrLn "| altitudine iniziale      = 100m,                                 |"
          putStrLn "| velocita' iniziale       = 10m/s.                                |"
          putStrLn "| Parametri di simulazione:                                        |"
          putStrLn "| secondi di simulazione   = 100s,                                 |"
          putStrLn "| costante gravitazionale  = 9.81m/(s^2).                          |"
          putStrLn "| Parametro richiesto:                                             |"
          putStrLn "| passo temporale, determina la distanza temporale                 |"
          putStrLn "| tra due punti di simulazione, un valore basso                    |"
          putStrLn "| permette una simulazione piu' accurata                           |"
          putStrLn "--------------------------------------------------------------------"

          dt <- acquisisci_dato_dt
          putStrLn $ show (calc_fugoide_semplice (read dt :: Double))

          putStrLn "--------------------------------------------------------------------"
          putStrLn "| Calcolo del moto fugoide con attrito                             |"
          putStrLn "| Parametri iniziali:                                              |"
          putStrLn "| velocita' iniziale                    = velocita' di trim,       |"
          putStrLn "| angolo iniziale                       = 0rad,                    |"
          putStrLn "| spostamento laterale  iniziale        = 0m,                      |"
          putStrLn "| spostamento verticale iniziale        = 1000m.                   |"
          putStrLn "| Parametri di simulazione:                                        |"
          putStrLn "| secondi di simulazione                = 100s,                    |"
          putStrLn "| velocita' di trim                     = 30m/s,                   |"
          putStrLn "| costante gravitazionale               = 9.81m/(s^2),             |"
          putStrLn "| coefficiente di resistenza dell'aria  = 0.025,                   |"
          putStrLn "| coefficiente di portanza              = 1N.                      |"
          putStrLn "| Parametro richiesto:                                             |"
          putStrLn "| passo temporale, determina la distanza temporale                 |"
          putStrLn "| tra due punti di simulazione, un valore basso                    |"
          putStrLn "| permette una simulazione piu' accurata                           |"
          putStrLn "--------------------------------------------------------------------"

          dt <- acquisisci_dato_dt
          putStrLn $ show (calc_fugoide_completo (read dt :: Double))

          putStrLn "--------------------------------------------------------------------"
          putStrLn "| Calcolo dell'equazione di convezione lineare a una dimensione    |"
          putStrLn "| Parametri iniziali:                                              |"
          putStrLn "| limite superiore del dominio spaziale    = 2.0,                  |"
          putStrLn "| limite inferiore del dominio spaziale    = 0.0,                  |" 
          putStrLn "| valore della parte alta della funzione   = 2.0,                  |" 
          putStrLn "| valore della parte bassa della funzione  = 1.0.                  |"
          putStrLn "| Parametri di simulazione:                                        |"
          putStrLn "| numero di passi temporali da effettuare  = 25 ,                  |" 
          putStrLn "| velocita' dell'onda                      = 1.0.                  |" 
          putStrLn "| Parametri richiesti all'utente:                                  |" 
          putStrLn "| numero di punti che compongono la funzione d'onda,               |"
          putStrLn "| un valore alto permette una simulazione piu' accurata.           |"
          putStrLn "| Passo temporale, determina la distanza temporale                 |"
          putStrLn "| tra due punti di simulazione, un valore basso                    |"
          putStrLn "| permette una simulazione piu' accurata                           |"
          putStrLn "--------------------------------------------------------------------"

          (nx,dt) <- acquisisci_dati_conv 
          putStrLn $ show (calc_convezione (read nx :: Int) (read dt :: Double))

          putStrLn "--------------------------------------------------------------------"
          putStrLn "| Calcolo dell'equazione di Burgers a una dimensione               |"
          putStrLn "| Parametri iniziali:                                              |"
          putStrLn "| limite superiore del dominio spaziale    = 2.0 * pi,             |"
          putStrLn "| limite inferiore del dominio spaziale    = 0.0.                  |" 
          putStrLn "| Parametri di simulazione:                                        |"
          putStrLn "| tempo finale di simulazione              = 0.6s,                 |" 
          putStrLn "| coefficiente di diffusione               = 1.0m^2/s,             |" 
          putStrLn "| costante di Courant-Friedrichs-Lewy      = 0.1.                  |" 
          putStrLn "| Parametri richiesti all'utente:                                  |" 
          putStrLn "| numero di punti che compongono la funzione d'onda                |"
          putStrLn "--------------------------------------------------------------------"

          nx <- acquisisci_dato_nxb 
          putStrLn $ show (calc_burgers (read nx :: Int))


{- Inizio sezione input/output -}

{- L'azione input/output acquisisci_dato_dt acquisisce un parametro numerico
   reale di simulazione, ovvero la lunghezza del passo temporale.-}

acquisisci_dato_dt :: IO String
acquisisci_dato_dt = do putStr "Digita lunghezza del passo temporale: "
                        dt <- getLine
                        if ((read dt :: Double) > 0)
                          then return dt
                        else do putStrLn "Acquisizione errata!"
                                putStrLn "Il valore deve essere maggiore di zero."
                                acquisisci_dato_dt 




{- L'azione input/output acquisisci_dati_conv acquisisce due parametri numerici
   di simulazione per l'equazione di convezione: il primo, un naturale per il 
   numero di punti della funzione d'onda; il secondo un reale per la lunghezza
   del passo temporale. -}

acquisisci_dati_conv :: IO (String, String)
acquisisci_dati_conv = do putStr "Digita il numero di punti totali della funzione d'onda: "
                          nx <- getLine
                          if (((read nx  :: Integer) == 0) ||
                             ((read nx  :: Integer) == 1)) 
                            then return (nx, "0")
                          else if ((read nx :: Integer) > 1)
                            then do dt <- acquisisci_dato_dt
                                    return (nx, dt)
                          else  do putStrLn "Acquisizione errata!"
                                   putStrLn "Il valore deve essere un numero naturale."
                                   acquisisci_dati_conv


{- L'azione input/output acquisisci_dato_nxb acquisisce un parametro numerico
   naturale di simulazione, ovvero il numero totale di punti della funzione
   d'onda per il calcolo dell'ecquazione di Burgers. -}

acquisisci_dato_nxb :: IO String
acquisisci_dato_nxb = do putStr "Digita il numero di punti totali della funzione d'onda: "
                         nx <- getLine
                         if ((read nx :: Integer) >= 0)
                           then return nx
                         else do putStrLn "Acquisizione errata!"
                                 putStrLn "Il valore deve essere un numero naturale."
                                 acquisisci_dato_nxb 



{- Fine sezione input/output -}


{- Costanti globali -}

{- Forza gravitazionale terrestre. -}
cG :: Double
cG = 9.81 

{- Coefficiente di diffusione -}
nu :: Double
nu = 0.07  

{- Velocita' di trim del velivolo, misurato in m/s -}
vTrim :: Double
vTrim = 30.0     

{- Tipo di dato che rappresenta una coppia di elementi uguali. -}
type Coppia a = (a,a)

{-  Tipo di dato che rappresenta una quadrupla di elementi uguali -}
type Quadrupla a = (a,a,a,a)


{- Inizio sezione fugoide semplice -}


{- La funzione calc_fugoide_semplice calcola il moto fugoide privo di attrito di 
   un velivolo generico:
   - il suo unico argomento e' la lunghezza del passo temporale dt. -}

calc_fugoide_semplice :: Double -> [Double]
calc_fugoide_semplice dt  = z0 : calc_moto_semplice (z0, b0) dt passi_temporali
   where
      z0              = 100.0               -- Altitudine iniziale del velivolo
      b0              = 10.0                -- Velocita' iniziale del velivolo
      tempo           = 100.0               -- Numero di secondi di simulazione
      passi_temporali = floor(tempo/dt) + 1 -- Numero di punti in cui effettuare il calcolo



{- La funzione calc_moto_semplice calcola numericamente l'integrazione del moto fugoide:
   - il primo argomento e' una coppia di valori, ovvero altitudine e velocita' 
     del velivolo;
   - il secondo argomento e' la lunghezza del passo temporale dt;
   - il terzo argomento e' il numero di passi che sono ancora da effettuare. -}

calc_moto_semplice :: Coppia Double -> Double -> Int -> [Double]
calc_moto_semplice dA@(dAA,_) dt len | len == 0               = [dBA]
                                     | otherwise              = dBA : calc_prossimo_punto
   where
      dB@(dBA,_)           = passo_eulero_semplice dA dt
      calc_prossimo_punto  = calc_moto_semplice dB dt (len - 1)

{- La funzione passo_eulero_semplice applica il metodo di Eulero ad una coppia di numeri. La
   funzione approssima la soluzione al tempo t_(n+1) tramite il valore della funzione 
   al tempo t_n ed un opportuno passo temporale:
   - il primo argomento e' una coppia di valori, ovvero la posizione e direzione del 
     velivolo al momento t_n;
   - il secondo argomento e' la lunghezza del passo temporale dt. -}

passo_eulero_semplice :: Coppia Double -> Double -> Coppia Double
passo_eulero_semplice dA@(y@altitudine, v@velocita) dt = somma_coppia dA (molt_coppia_scalare (rhs_semplice dA) dt)


{- La funzione rhs_semplice viene utilizzata per l'applicazione dell'equazione del moto fugoide:
   - il suo unico argomento e' una coppia di valori, ovvero altitudine e velocita' 
     del velivolo. -}

rhs_semplice :: Coppia Double -> Coppia Double
rhs_semplice dA@(y@alt, v@vel) = (v, cG * (1-y/zt))
   where
      zt = 100.0 -- Altitudine centrale all'oscillazione


{- Fine sezione fugoide semplice -}


{- Inizio sezione fugoide completo -}


{- La funzione calc_fugoide_completo calcola il moto fugoide con attrito di 
   un velivolo generico:
   - il suo unico argomento e' la lunghezza del passo temporale dt. -}

calc_fugoide_completo :: Double -> [Double]
calc_fugoide_completo dt  = y0 : calc_moto_completo (v0, theta0, x0, y0) dt passiTemporali
   where
      v0             = vTrim               -- La velocita' iniziale, in questo caso quella di trim
      theta0         = 0.0                 -- Angolo iniziale del velivolo
      x0             = 0.0                 -- Spostamento orizzontale iniziale del velivolo
      y0             = 1000.0              -- Altitudine iniziale del velivolo
      tempo          = 100.0               -- Numero di secondi di simulazione
      passiTemporali = floor(tempo/dt) + 1 -- Numero di punti in cui effettuare il calcolo  


{- La funzione calc_moto_completo calcola numericamente l'integrazione del moto fugoide:
   - il primo argomento e' una quadrupla di valori, ovvero velocita', angolo,
     spostamento laterale e verticale del velivolo; 
   - il secondo argomento e' la lunghezza del passo temporale dt;
   - il terzo argomento e' il numero di passi che sono ancora da effettuare. -}

calc_moto_completo :: Quadrupla Double -> Double -> Int -> [Double]
calc_moto_completo dA dt len | len == 0   = [dBD]
                             | otherwise  = dBD : calc_prossimo_punto
   where
      dB@(_,_,_, dBD)      = passo_eulero_completo dA dt
      calc_prossimo_punto  = calc_moto_completo dB dt (len - 1)


{- La funzione passo_eulero_completo applica il metodo di Eulero ad una quadrupla di numeri. La
   funzione approssima la soluzione al tempo t_(n+1) tramite il valore della funzione 
   al tempo t_n ed un opportuno passo temporale:
   - il primo argomento e' una coppia di valori, ovvero la velocita', angolo, spostamento 
     laterale e verticale del velivolo al momento t_n;
   - il secondo argomento e' la lunghezza del passo temporale dt. -}

passo_eulero_completo :: Quadrupla Double -> Double -> Quadrupla Double
passo_eulero_completo dA@(v,theta,x,y) dt = somma_quadrupla dA (molt_quadrupla_scalare (rhs_completo (v,theta)) dt)


{- La funzione rhs_completo viene utilizzata per l'applicazione dell'equazione del moto fugoide:
   - il suo unico argomento e' una coppia di valori, ovvero la velocita' e l'angolo del velivolo. -}

rhs_completo :: Coppia Double -> Quadrupla Double
rhs_completo dA@(v,theta) = (- (cG * sin theta) - (cR / cP)*cG/vTrim**2*v**2,
                             - (cG * cos theta / v) + cG/vTrim**2*v,
                             v*cos theta,
                             v*sin theta)
   where
      cR = 0.025  -- Coefficiente di resistenza all'aria
      cP = 1.0    -- Coefficiente di portanza


{- Fine sezione fugoide completo -}


{- Inizio sezione funzioni ausiliarie -}


{- La funzione somma_coppia prende due coppie dello stesso tipo e 
   restituisce la coppia risultante dalla somma rispettiva degli elementi. -}

somma_coppia :: (Num a) => Coppia a -> Coppia a -> Coppia a
somma_coppia (a1,b1) (a2,b2) = (a1+a2, b1+b2)

{- La funzione molt_coppia_scalare prende una coppia di elementi numerici
   ed un valore numerico e restituisce la coppia risultante dalla 
   moltiplicazione rispettiva degli elementi:
   - il primo argomento e' una coppia di elementi;
   - il secondo argomento e' un valore numerico.  -}

molt_coppia_scalare :: (Num a) => Coppia a -> a -> Coppia a
molt_coppia_scalare (a1,b1) b = (a1*b, b1*b)

{- La funzione somma_quadrupla prende due quadruple dello stesso tipo e 
   restituisce la quadrupla risultante dalla somma rispettiva degli elementi -}

somma_quadrupla :: (Num a) => Quadrupla a -> Quadrupla a -> Quadrupla a
somma_quadrupla (a1,b1,c1,d1) (a2,b2,c2,d2) = (a1+a2, b1+b2, c1+c2, d1+d2)

{- La funzione molt_quadrupla_scalare prende una quadrupla di elementi numerici
   ed un valore numerico e restituisce la quadrupla risultante dalla 
   moltiplicazione rispettiva degli elementi:
   - il primo argomento e' una quadrupla di elementi;
   - il secondo argomento e' un valore numerico. -}

molt_quadrupla_scalare :: (Num a) => Quadrupla a -> a -> Quadrupla a
molt_quadrupla_scalare (a1,b1,c1,d1) b = (a1*b, b1*b, c1*b, d1*b)


{- Fine sezione funzioni ausiliarie -}


{- Inizio sezione convezione lineare -}


{- La funzione calc_convezione calcola l'integrazione numerica
   dell'equazione di convezione lineare a una dimensione:
   - il primo argomento e' il numero di punti totali della funzione
     d'onda;
   - il secondo argomento e' la lunghezza del passo temporale. -}

calc_convezione :: Int -> Double -> [Double]
calc_convezione nx dt | nx == 0 || nx == 1    = cond_iniziale nx onda_quadra lmt_inf lmt_sup
                      | otherwise             = tempo_conv nt nx c dx dt (cond_iniziale nx onda_quadra lmt_inf lmt_sup)
   where
      lmt_inf = 0.0                                     -- limite inferiore del dominio spaziale 
      lmt_sup = 2.0                                     -- limite superiore del dominio spaziale
      nt      = 25                                      -- numero complessivo di passi temporali che deve effettuare l'algoritmo 
      dx      = lmt_sup / (fromIntegral(nx :: Int) - 1) -- distanza tra qualsiasi coppia di punti della griglia adiacenti 
      c       = 1.0                                     -- velocità dell'onda 

{- La funzione tempo_conv calcola numericamente l'integrazione della
   funzione rispetto al parametro temporale dt:
   - il primo argomento e' il numero di passi temporali totali che la
     funzione d'onda deve compiere; 
   - il secondo argomento e' il numero di passi spaziali utilizzati dal
     predicato spazio_conv;
   - il terzo argomento e' la costante di velocità dell'onda;     
   - il quarto argomento e' la lunghezza del passo spaziale;
   - il quinto argomento e' la lunghezza del passo temporale;
   - il sesto argomento e' la funzione d'onda ricalcolata. -}

tempo_conv :: Int -> Int -> Double -> Double -> Double -> [Double] -> [Double]
tempo_conv 0 _ _ _ _ onda     = onda
tempo_conv nt nx c dx dt onda = tempo_conv (nt - 1) nx c dx dt ((head onda) : spazio_conv 1 c dx dt onda) 


{- La funzione spazio_conv calcola numericamente l'integrazione della
   funzione rispetto al parametro spaziale dx:
   - il primo argomento e' il numero di passi temporali che la funzione
     d'onda ha compiuto;
   - il secondo argomento e' la costante di velocità dell'onda;      
   - il terzo argomento e' la lunghezza del passo spaziale;
   - il quarto argomento e' la lunghezza del passo temporale;
   - il quinto argomento e' la funzione d'onda. -}

spazio_conv :: Int -> Double -> Double -> Double -> [Double] -> [Double] 
spazio_conv i c dx dt lx  | i == length lx - 1 = [passo_eulero]
                          | otherwise          = (passo_eulero) : spazio_conv (i+1) c dx dt lx
   where
      passo_eulero =  lx !! i - c * dt /dx *(lx !! i - lx !! (i-1))

{- La funzione onda_quadra calcola la funzione d'onda quadra:
   - il suo unico argomento e' la lista di punti equidistanti del dominio
     spaziale. -}

onda_quadra :: Double -> Double
onda_quadra x | x >= 0.5 && x <= 1.0 = onda_sup
              | otherwise            = onda_inf
   where
      onda_sup = 2.0 -- valori assunti dalla parte alta della funzione d'onda quadra
      onda_inf = 1.0 -- valori assunti dalla parte bassa della funzione d'onda quadra


{- Fine sezione convezione lineare -}


{- Inizio sezione equazione di Burgers -}


{- La funzione calc_burgers calcola l'integrazione numerica
   dell'equazione di burgers a una dimensione:
   - il suo unico argomento e' il numero di punti totali della funzione
     d'onda. -}

calc_burgers :: Int -> [Double]
calc_burgers nx = tempo_burg nt nx dx dt (cond_iniziale nx onda_dente_sega lmt_inf lmt_sup)
   where
      lmt_inf  = 0.0                                     -- limite inferiore del dominio spaziale 
      lmt_sup  = 2.0 * pi                                -- limite superiore del dominio spaziale 
      dx       = lmt_sup / (fromIntegral(nx :: Int) - 1) -- distanza tra qualsiasi coppia di punti della griglia adiacenti 
      sigma    = 0.1                                     -- costante di Courant-Friedrichs-Lewy (CFL)
      dt       = sigma * dx**2 / nu                      -- lunghezza del passo temporale 
      t_fine   = 0.6                                     -- tempo totale di simulazione 
      nt       = floor(t_fine / dt)                      -- numero complessivo di passi temporali che deve effettuare l'algoritmo 


{- La funzione tempo_burg calcola numericamente l'integrazione della
   funzione rispetto al parametro temporale dt:
   - il primo argomento e' il numero di passi temporali totali che la
     funzione d'onda deve compiere; 
   - il secondo argomento e' il numero di passi spaziali utilizzati dalla
     funzione spazio_burg;       
   - il terzo argomento e' la lunghezza del passo spaziale;
   - il quarto argomento e' la lunghezza del passo temporale;
   - il quinto argomento e' la funzione d'onda ricalcolata. -}

tempo_burg :: Int -> Int -> Double -> Double -> [Double] -> [Double]
tempo_burg 0 _ _ _ onda     = onda
tempo_burg nt nx dx dt onda = tempo_burg (nt - 1) nx dx dt (bordo_inf : spazio_burg 1 dx dt onda)
   where
      bordo_inf = head onda - head onda * dt/dx * (head onda - last onda) +
                  nu*dt/dx**2 * ((head $ tail onda) - 2*(head onda) + last onda) -- condizione di bordo inferiore

{- La funzione spazio_burg calcola numericamente l'integrazione della
   funzione rispetto al parametro spaziale dx:
   - il primo argomento e' l'indice per accedere agli elementi della 
     lista, viene utlizzato da passo_eulero; 
   - il secondo argomento e' la lunghezza del passo spaziale;
   - il terzo argomento e' la lunghezza del passo temporale;
   - il quarto argomento e' la funzione d'onda. -}

spazio_burg :: Int -> Double -> Double -> [Double] -> [Double]
spazio_burg i dx dt lx | i == length lx - 1 = [bordo_sup]
                       | otherwise          = (passo_eulero) : spazio_burg (i+1) dx dt lx
   where
      bordo_sup    = (last lx) - (last lx) * dt/dx * ((last lx) - (last $ init lx)) +
                     nu*dt/dx**2*(head lx - 2*(last lx) + (last $ init lx))
      passo_eulero = (lx !! i - lx !! i * dt/dx * (lx !! i - lx !! (i-1)) + 
                      nu*dt/dx**2*(lx !! (i+1) - 2*(lx !! i) + lx !! (i-1)))



{- La funzione onda_dente_sega calcola la funzione d'onda a dente di 
   sega 'u':
   - il suo unico argomento e' la lista di punti equidistanti del 
     dominio spaziale. 
   Per il calcolo dell'onda si fa uso dei predicati phi e phi_primo
   che sono rispettivamente la funzione e la sua derivata.  -}

onda_dente_sega :: Double -> Double
onda_dente_sega x = u t0 x nu
   where
      t0 = 0.0                                                                              
      phi_primo t0 x nu = -(-8*t0 + 2*x)*exp(-(-4*t0 + x)**2/(4*nu*(t0 + 1)))/(4*nu*(t0 + 1)) - 
                          (-8*t0 + 2*x - 4*pi)*exp(-(-4*t0 + x - 2*pi)**2/(4*nu*(t0 + 1)))/(4*nu*(t0 + 1))       
      phi t0 x nu       = exp(-(x-4*t0)**2/(4*nu*(t0+1))) + exp(-(x-4*t0-2*pi)**2/(4*nu*(t0+1)))
      u t0 x nu         = -2*nu*((phi_primo t0 x nu) / (phi t0 x nu))+4


{- Fine sezione equazione di Burgers -}


{- Inizio sezione funzioni condivise -}


{- La funzione cond_iniziale calcola la condizione iniziale (una funzione)
   per l'integrazione numerica dell'equazione di convezione e di Burgers:
   - il primo argomento e' il numero di punti della griglia spaziale;
   - il secondo argomento e' la funzione onda_quadra (onda_dente_sega) 
     utilizzata per il calcolo delle omonime funzioni;
   - il terzo argomento e' il limite inferiore del dominio spaziale;
   - il quarto argomento e' il limite superiore del dominio spaziale. -}

cond_iniziale :: Int -> (Double -> Double) -> Double -> Double -> [Double]
cond_iniziale nx onda lmt_inf lmt_sup = [onda x | x <- lx]
   where
      lx = gen_punti_equi nx lmt_inf lmt_sup

{- La funzione gen_punti_equi genera una lista di punti equidistanti tra loro:
   - il primo argomento e' il numero di punti che si vuole generare;
   - il secondo argomento e' il limite inferiore della lista di punti;
   - il terzo argomento e' il limite superiore della lista di punti.
   Per il calcolo dei punti si fa uso della funzione calc_punti. -}

gen_punti_equi :: Int -> Double -> Double -> [Double]
gen_punti_equi 0 _ _      = []
gen_punti_equi nx inf sup = calc_punti 0 (nx - 1) inf (sup - inf)


calc_punti :: Int -> Int -> Double -> Double -> [Double]
calc_punti i nx inf dst | i == nx   = [inf]
                        | otherwise = inf : calc_punti (i + 1) nx (inf + (dst / fromIntegral(nx :: Int))) dst


{- Fine sezione funzioni condivise -}
