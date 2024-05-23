PRINCIPALI = main.tex logo-uniurb-2016.jpg.eps Makefile
  
#SORGENTI =            

main.pdf: $(PRINCIPALI) # $(SORGENTI)
        pdflatex main.tex
        pdflatex main.tex
        #dvipdfm -o tesi.pdf tesi.dvi
        acroread main.pdf &


pulisci:
      rm -f *.toc *.lof *.lot *.aux *.log    



pulisci_tutto:
#        rm -f *.pdf *.toc *.lof *.lot *.aux *.log sorgenti/01_capitolo/*.aux sorgenti/02_capitolo/*.aux \
        sorgenti/03_capitolo/*.aux sorgenti/04_capitolo/*.auxa.tex sorgenti/appendice/*.aux sorgenti/*.aux

