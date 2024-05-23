module Main where

import FugoideSemplice
import FugoideCompleto
import Convezione 
import Burgers

main::IO()
main = do 
          putStrLn "Progetto della sessione autunnale del corso Programmazione Logica e Funzionale"
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

          dt <- acquisisci_dato_dt "Digita la lunghezza del passo temporale:"
          putStrLn $ show (main_fugoide_semplice (read dt :: Float))

          putStrLn "--------------------------------------------------------------------"
          putStrLn "| Calcolo del moto fugoide con attrito                             |"
          putStrLn "| Parametri iniziali:                                              |"
          putStrLn "| velocita' iniziale                    = velocita' di trim,       |"
          putStrLn "| angolo iniziale                       = 0rad,                    |"
          putStrLn "| spostamento laterale  iniziale        = 0m,                      |"
          putStrLn "| spostamento verticale iniziale        = 1000m,                   |"
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

          dt <- acquisisci_dato_dt "Digita lunghezza del passo temporale:"
          putStrLn $ show (main_fugoide_completo (read dt :: Float))

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
          putStrLn "| un valore alto permette una simulazione piu' accurata            |"
          putStrLn "| passo temporale, determina la distanza temporale                 |"
          putStrLn "| tra due punti di simulazione, un valore basso                    |"
          putStrLn "| permette una simulazione piu' accurata                           |"
          putStrLn "--------------------------------------------------------------------"

          (nx,dt) <- acquisisci_dato_conv "Digita il numero di punti totali della funzione d'onda:"
                                          "Digita la lunghezza del passo temporale della funzione d'onda:"
          putStrLn $ show (main_convezione (read nx :: Int) (read dt :: Double))

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

          nx <- acquisisci_dato_nx "Digita il numero di punti totali della funzione d'onda:"
          putStrLn $ show (main_burgers (read nx :: Int))



{- Validazione input -}

{- La funzione acquisisci_dato_dt viene utilizzata per la lunghezza
   del passo temporale dt. -}

acquisisci_dato_dt :: String -> IO String
acquisisci_dato_dt s = do putStrLn s
                          dato <- getLine
                          if ((read dato :: Float) > 0)
                            then return dato
                          else do putStrLn "Acquisizione errata"
                                  putStrLn "Il valore deve essere maggiore di zero!"
                                  acquisisci_dato_dt s


{- La funzione acquisisci_dato_nx viene utilizzata per validare il
   numero totale dei punti della funzione d'onda. -}

acquisisci_dato_nx :: String -> IO String
acquisisci_dato_nx s = do putStrLn s
                          dato <- getLine
                          if ((read dato :: Integer) >= 0)
                            then return dato
                          else do putStrLn "Acquisizione errata"
                                  putStrLn "Il valore deve essere maggiore di zero!"
                                  acquisisci_dato_nx s


{- La funzione acquisisci_dato_conv viene utilizzata per validare 
   i dati in ingresso della funzione main_convezione. -}

acquisisci_dato_conv :: String -> String-> IO (String, String)
acquisisci_dato_conv s' s'' = do putStrLn s'
                                 dato <- getLine
                                 if (((read dato  :: Integer) == 0) ||
                                     ((read dato  :: Integer) == 1)) 
                                    then return (dato, "0")
                                 else if ((read dato :: Integer) > 1)
                                    then  do dt <- acquisisci_dato_dt s''
                                             return (dato, dt)
                                 else  do putStrLn "Acquisizione errata"
                                          putStrLn "Il valore deve essere maggiore di zero!"
                                          acquisisci_dato_conv s' s''






