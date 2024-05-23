{- Tipo di dato che rappresenta una coppia di elementi uguali. -}

type Coppia a = (a,a)

{-  Tipo di dato che rappresenta una quadrupla di elementi uguali -}

type Quadrupla a = (a,a,a,a)


{- Velocita' di trim del velivolo, misurato in m/s -}

vTrim :: Float
vTrim = 30.0     


{- La funzione calc_fugoide_semplice calcola il moto fugoide privo di attrito di 
   un velivolo generico:
   - il suo unico argomento e' la lunghezza del passo temporale dt. -}

calc_fugoide_semplice :: Float -> [Float]
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

calc_moto_semplice :: Coppia Float -> Float -> Int -> [Float]
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

passo_eulero_semplice :: Coppia Float -> Float -> Coppia Float
passo_eulero_semplice dA@(y@altitudine, v@velocita) dt = somma_coppia dA (molt_coppia_scalare (rhs_semplice dA) dt)


{- La funzione rhs_semplice viene utilizzata per l'applicazione dell'equazione del moto fugoide:
   - il suo unico argomento e' una coppia di valori, ovvero altitudine e velocita' 
     del velivolo. -}

rhs_semplice :: Coppia Float -> Coppia Float
rhs_semplice dA@(y@alt, v@vel)   = (v, cG * (1-y/zt))
    where
        cG              = 9.81  -- Costante gravitazionale terrestre
        zt              = 100.0 -- Altitudine centrale all'oscillazione


{- La funzione calc_fugoide_completo calcola il moto fugoide con attrito di 
   un velivolo generico:
  - il suo unico argomento e' la lunghezza del passo temporale dt. -}

calc_fugoide_completo :: Float -> [Float]
calc_fugoide_completo dt  = y0 : calc_moto_completo (v0, theta0, x0, y0) dt passiTemporali
   where
      v0                = vTrim               -- La velocita' iniziale, in questo caso quella di trim
      theta0            = 0.0                 -- Angolo iniziale del velivolo
      x0                = 0.0                 -- Spostamento orizzontale iniziale del velivolo
      y0                = 1000.0              -- Altitudine iniziale del velivolo
      tempo             = 100.0               -- Numero di secondi di simulazione
      passiTemporali    = floor(tempo/dt) + 1 -- Numero di punti in cui effettuare il calcolo  


{- La funzione calc_moto_completo calcola numericamente l'integrazione del moto fugoide:
   - il primo argomento e' una quadrupla di valori, ovvero velocita', angolo,
     spostamento laterale e verticale del velivolo; 
   - il secondo argomento e' la lunghezza del passo temporale dt;
   - il terzo argomento e' il numero di passi che sono ancora da effettuare. -}

calc_moto_completo :: Quadrupla Float -> Float -> Int -> [Float]
calc_moto_completo dA dt len | len == 0               = [dBD]
                    | otherwise              = dBD : calc_prossimo_punto
                    where
                        dB@(_,_,_, dBD)      = passo_eulero_completo dA dt
                        calc_prossimo_punto  = calc_moto_completo dB dt (len - 1)


{- La funzione passo_eulero_completo applica il metodo di Eulero ad una quadrupla di numeri. La
   funzione approssima la soluzione al tempo t_(n+1) tramite il valore della funzione 
   al tempo t_n ed un opportuno passo temporale:
   - il primo argomento e' una coppia di valori, ovvero la velocita', angolo, spostamento 
     laterale e verticale del velivolo al momento t_n;
   - il secondo argomento e' la lunghezza del passo temporale dt. -}

passo_eulero_completo :: Quadrupla Float -> Float -> Quadrupla Float
passo_eulero_completo dA@(v,theta,x,y) dt = somma_quadrupla dA (molt_quadrupla_scalare (rhs_completo (v,theta)) dt)


{- La funzione rhs_completo viene utilizzata per l'applicazione dell'equazione del moto fugoide:
   - il suo unico argomento e' una coppia di valori, ovvero la velocita' e l'angolo del velivolo. -}

rhs_completo :: Coppia Float -> Quadrupla Float
rhs_completo dA@(v,theta) = (- (cG * sin theta) - (cR / cP)*cG/vTrim**2*v**2,
                        - (cG * cos theta / v) + cG/vTrim**2*v,
                        v*cos theta,
                        v*sin theta)
   where
      cG = 9.81   -- Costante gravitazionale terrestre
      cR = 0.025  -- Coefficiente di resistenza all'aria
      cP = 1.0    -- Coefficiente di portanza



{- Funzioni ausiliarie -}

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


