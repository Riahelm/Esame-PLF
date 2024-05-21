
# sorgenti predicati
# modulo/predicati_testing.pro
# modulo/ausiliarie/linspace.pro
# modulo/ausiliarie/predicati_ausiliari.pro
# modulo/cond_iniziale/condizione_iniziale.pro
# modulo/predicati_eulero/eulero.pro
# modulo/convezione/spazio.pro
# modulo/convezione/tempo.pro
# modulo//validazione/ctl_input.pro
# modulo/master/main.pro 
# modulo/master/test.pro



gplc modulo/convezione/* modulo/predicati_eulero/* modulo/cond_iniziale/* \
     modulo/ausiliarie/* modulo/validazione/* modulo/master/* modulo/predicati_testing.pro -o test

./test

rm -r test
