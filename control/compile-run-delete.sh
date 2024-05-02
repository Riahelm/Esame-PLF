#!/bin/bash


#src/master/module/main.hs -- main.hs

#moduli fugoide completo:
#src/fugoideCompleto/modulo/condizioni_iniziali.hs
#src/fugoideCompleto/modulo/dati_problema.hs
#src/fugoideCompleto/modulo/fugoideCompleto.hs
#src/fugoideCompleto/modulo/funzioni_ausiliarie.hs

#moduli convezione:
#src/convection/modulo/funzioni_ausiliarie.hs
#src/convection/modulo/dati_problema.hs --removed
#src/convection/modulo/condizioni_iniziali.hs
#src/convection/modulo/main_convezione.hs

#ghc src/convection/modulo/*.hs src/master/module/main.hs -o convezione

#moduli burgers
#src/convection/modulo/funzioni_ausiliarie.hs
#src/burgers/modulo/dati_problema.hs 
#src/burgers/modulo/condizioni_iniziali.hs
#src/burgers/modulo/main_burgers.hs

#ghc src/convection/modulo/funzioni_ausiliarie.hs src/burgers/modulo/*.hs src/master/module/main.hs -o burgers

ghc src/fugoide/completo/modulo/*.hs src/fugoide/semplice/modulo/*.hs src/convection/modulo/*.hs src/burgers/modulo/*.hs src/master/module/main.hs -o fugconvburgers

#!/bin/bash

#rm -r <name_directory>/*.{<list extensions>}
rm -r  src/master/module/*.{o,hi}
rm -r  src/burgers/modulo/*.{o,hi}
rm -r  src/convection/modulo/*.{o,hi}
rm -r  src/fugoideCompleto/modulo/*.{o,hi}

#Funzionalità aggiuntiva 
./fugconvburgers

rm -r fugconvburgers


