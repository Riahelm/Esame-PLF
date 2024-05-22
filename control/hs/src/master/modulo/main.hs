module Main where

import FugoideSemplice
import FugoideCompleto
import Convezione 
import Burgers

main::IO()
main = do putStrLn "Calcolo del moto di fugoide senza attrito"
          dt <- acquisisciDato "Digita lunghezza del passo temporale:"
          putStrLn $ show (main_fugoide_semplice (read dt :: Float))
          putStrLn "Calcolo del moto di fugoide con attrito"
          dt <- acquisisciDato "Digita lunghezza del passo temporale:"
          putStrLn $ show (main_fugoide_completo (read dt :: Float))
          putStrLn "Calcolo dell'equazione di convezione lineare a una dimensione"
          nx <- acquisisciDato "Digita il numero di punti totali della funzione d'onda:"
          dt <- acquisisciDato "Digita la lunghezza del passo temporale della funzione d'onda:"
          putStrLn $ show (main_convezione (read nx :: Int) (read dt :: Double))
          putStrLn "Calcolo dell'equazione di Burgers a una dimensione"
          nx <- acquisisciDato "Digita il numero di punti totali della funzione d'onda:"
          putStrLn $ show (main_burgers (read nx :: Int))



acquisisciDato :: String -> IO String
acquisisciDato s | c         = controlla_dato s
                 | otherwise = acquisisciDato  s --"Aquisizione errata. " : s
	where
          dato = controlla_dato s
          c    = (signum (read dato :: Float)) == 1                    

{-
		      do putStrLn s
                      dato <- getLine
                      if (signum (read dato :: Float)) == 1
                        then return dato
                      else do putStrLn "Acquisizione errata"
                              putStrLn "Il valore deve essere maggiore di zero!"
                              acquisisciDato s
-}
        

controlla_dato :: String -> IO String 
controlla_dato s = do putStrLn s
		      dato <- getLine  
                      return  dato

