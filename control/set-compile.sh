#!/bin/bash


#code/master/module/main.hs -- main.hs

#moduli fugoide completo:
#code/fugoideCompleto/modulo/condizioni_iniziali.hs
#code/fugoideCompleto/modulo/dati_problema.hs
#code/fugoideCompleto/modulo/fugoideCompleto.hs
#code/fugoideCompleto/modulo/funzioni_ausiliarie.hs
ghc code/fugoideCompleto/modulo/*.hs code/master/module/main.hs -o fullPhugoid

#moduli convezione:
#code/convection/modulo/funzioni_ausiliarie.hs
#code/convection/modulo/dati_problema.hs --removed
#code/convection/modulo/condizioni_iniziali.hs
#code/convection/modulo/main_convezione.hs

#ghc code/convection/modulo/*.hs code/master/module/main.hs -o convezione

#moduli burgers
#code/convection/modulo/funzioni_ausiliarie.hs
#code/burgers/modulo/dati_problema.hs 
#code/burgers/modulo/condizioni_iniziali.hs
#code/burgers/modulo/main_burgers.hs

#ghc code/convection/modulo/funzioni_ausiliarie.hs code/burgers/modulo/*.hs code/master/module/main.hs -o burgers

ghc code/convection/modulo/*.hs code/burgers/modulo/*.hs code/master/module/main.hs -o convburgers


