
# sorgenti funioni ausiliarie
# modulo/funzioni_ausiliarie/linspace.pro
# modulo/cond_iniziale/condizione_iniziale.pro


gplc modulo/cond_iniziale/* modulo/funzioni_ausiliarie/* modulo/master/main.pro -o test

./test

rm -r test
