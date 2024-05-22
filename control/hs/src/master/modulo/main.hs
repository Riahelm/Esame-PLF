module Main where

import FugoideSemplice
import FugoideCompleto
import Convezione 
import Burgers

main::IO()
main = do putStrLn "Calcolo del moto di fugoide senza attrito"
          dt <- acquisisci_dato_dt "Digita lunghezza del passo temporale:"
          putStrLn $ show (main_fugoide_semplice (read dt :: Float))
          putStrLn "Calcolo del moto di fugoide con attrito"
          dt <- acquisisci_dato_dt "Digita lunghezza del passo temporale:"
          putStrLn $ show (main_fugoide_completo (read dt :: Float))
          putStrLn "Calcolo dell'equazione di convezione lineare a una dimensione"
          --nx <- acquisisciDato "Digita il numero di punti totali della funzione d'onda:"
          --dt <- acquisisciDato "Digita la lunghezza del passo temporale della funzione d'onda:"
	  (nx,dt) <- acquisisci_dato_conv "Digita il numero di punti totali della funzione d'onda:"
                                          "Digita la lunghezza del passo temporale della funzione d'onda:"
          putStrLn $ show (main_convezione (read nx :: Int) (read dt :: Double))
          putStrLn "Calcolo dell'equazione di Burgers a una dimensione"
          nx <- acquisisci_dato_nx "Digita il numero di punti totali della funzione d'onda:"
          putStrLn $ show (main_burgers (read nx :: Int))



{- Validazione input -}

{- La funzione acquisisci_dato_dt viene utilizzata per la lunghezza
   del passo temporale dt. -}

acquisisci_dato_dt :: String -> IO String
acquisisci_dato_dt s = do putStrLn s
                          dato <- getLine
                          if (signum (read dato :: Float)) == 1
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
   i dati in ingresso dell funzione main_convezione. -}

acquisisci_dato_conv :: String -> String-> IO (String, String)
acquisisci_dato_conv s' s'' = do putStrLn s'
                                 dato <- getLine
                                 if (((read dato :: Integer) == 0) ||
                                    ((read dato  :: Integer) == 1)) 
                                   then return (dato, "0")
				 else if ((read dato :: Integer) > 1)
                                   then do dt <- acquisisci_dato_dt s''
                                           return (dato, dt)
                                 else do putStrLn "Acquisizione errata"
                                         putStrLn "Il valore deve essere maggiore di zero!"
                                         acquisisci_dato_conv s' s''






