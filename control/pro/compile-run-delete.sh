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

gplc      src/convezione/test/modulo/ausiliarie/linspace.pro \
          src/burgers/test/modulo/ausiliarie/predicati_ausiliari.pro \
          src/convezione/test/modulo/cond_iniziale/condizione_iniziale.pro \
          src/convezione/test/modulo/predicati_eulero/eulero.pro \
          src/convezione/test/modulo/convezione/spazio.pro \
          src/convezione/test/modulo/convezione/tempo.pro \
          src/convezione/test/modulo/master/main.pro \
          src/convezione/test/modulo/validazione/ctl_input.pro \
          src/burgers/test/modulo/cond_iniziale/condizione_iniziale.pro \
          src/burgers/test/modulo/predicati_eulero/eulero.pro \
          src/burgers/test/modulo/burgers/spazio.pro \
          src/burgers/test/modulo/burgers/tempo.pro src/burgers/test/modulo/master/main.pro src/master/modulo/main_fug.pro -o simulazione

          
./simulazione

rm -r simulazione
