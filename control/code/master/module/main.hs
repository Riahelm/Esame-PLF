module Main where

import Phugoid 

main::IO()
main = do --putStrLn "Calcolo del moto di fugoide senza attrito"
	  --putStrLn "Digita lunghezza del passo temporale:"
	  --dt <- getChar 
          --putStrLn $ show (main_simplePhugoid (read dt :: Double))
	  putStrLn "Calcolo del moto di fugoide con attrito"
	  putStrLn "Digita lunghezza del passo temporale:"
	  dt <- getChar
          putStrLn $ show (main_fullPhugoid (read [dt]))
          -- putStrLn "Calcolo dell'equazione di convezione lineare unidimensionale"
          

