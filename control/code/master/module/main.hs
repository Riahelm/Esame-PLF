module Main where

import Convezione 
import Burgers
import Fugoide

main::IO()
main = do 
          putStrLn "Calcolo del moto di fugoide senza attrito"
          putStrLn "Digita lunghezza del passo temporale:"
	      dt <- getLine
          putStrLn $ show (mainFugoide(read dt :: Double))
          {-
	      putStrLn "Calcolo del moto di fugoide con attrito"
	      putStrLn "Digita lunghezza del passo temporale:"
	      dt <- getChar
          putStrLn $ show (main_fullPhugoid (read [dt]))
          -}
          putStrLn "Calcolo dell'equazione di convezione lineare a una dimensione"
          putStrLn "Digita il numero di punti totali della funzione d'onda:"
          nx <- getLine
          putStrLn "Digita la lunghezza del passo temporale della funzione d'onda:"
          dt <- getLine
          putStrLn $ show (main_convezione (read nx :: Int) (read dt :: Double))
          putStrLn "Calcolo dell'equazione di Burgers a una dimensione"
          putStrLn "Digita il numero di punti totali della funzione d'onda:"
          nx <- getLine
          putStrLn $ show (main_burgers (read nx :: Int))
          




          
          

