#!/bin/bash

#code/master/module/main.hs -- main.hs
#code/phugoid/phugoid.hs    -- phugoid.hs
#...
#ghc code/phugoid/phugoid.hs code/master/module/main.hs -o start

#moduli convezione:
mod_funz=/convection/modulo/funzioni_ausiliarie.hs
mod_dati=code/convection/modulo/dati_problema.hs
mod_cond=code/convection/modulo/condizioni_iniziali.hs
mod_conv=code/convection/modulo/main_convezione.hs

ghc mod_funz mod_dati mod_cond mod_conv -o convezione



