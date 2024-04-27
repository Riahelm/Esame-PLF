#!/bin/bash

#code/master/module/main.hs -- main.hs
#code/phugoid/phugoid.hs    -- phugoid.hs
#...
#ghc code/phugoid/phugoid.hs code/master/module/main.hs -o start

#moduli convezione:
#code/convection/modulo/funzioni_ausiliarie.hs
#code/convection/modulo/dati_problema.hs --removed
#code/convection/modulo/condizioni_iniziali.hs
#code/convection/modulo/main_convezione.hs

#moduli burgers
#code/convection/modulo/funzioni_ausiliarie.hs
#code/burgers/modulo/dati_problema.hs 
#code/burgers/modulo/condizioni_iniziali.hs
#code/burgers/modulo/main_burgers.hs

#ghc code/convection/modulo/*.hs code/master/module/main.hs -o convezione

ghc code/convection/modulo/funzioni_ausiliarie.hs code/burgers/modulo/*.hs code/master/module/main.hs -o burgers

