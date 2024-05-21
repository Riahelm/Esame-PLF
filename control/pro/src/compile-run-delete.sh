# sorgenti predicati: convezione/test... \ burgers/test...
# modulo/predicati_testing.pro
# modulo/ausiliarie/linspace.pro
# modulo/ausiliarie/predicati_ausiliari.pro
# modulo/cond_iniziale/condizione_iniziale.pro
# modulo/predicati_eulero/eulero.pro
# modulo/validazione/ctl_input.pro
# modulo/convezione/spazio.pro
# modulo/convezione/tempo.pro
# modulo/master/main.pro 
# modulo/master/test.pro

gplc      convezione/test/modulo/ausiliarie/linspace.pro \
          burgers/test/modulo/ausiliarie/predicati_ausiliari.pro \
          convezione/test/modulo/cond_iniziale/condizione_iniziale.pro \
          convezione/test/modulo/predicati_eulero/eulero.pro \
          convezione/test/modulo/convezione/spazio.pro \
          convezione/test/modulo/convezione/tempo.pro \
          convezione/test/modulo/master/main.pro \
          convezione/test/modulo/validazione/ctl_input.pro \
          burgers/test/modulo/cond_iniziale/condizione_iniziale.pro \
          burgers/test/modulo/predicati_eulero/eulero.pro \
          burgers/test/modulo/burgers/spazio.pro \
          burgers/test/modulo/burgers/tempo.pro burgers/test/modulo/master/main.pro master/modulo/main_fug.pro -o simulazione

          
./simulazione

rm -r simulazione
