#Added phugoid folder and source file

#TODOs:
	1) Make modules for the shared functions			(Gab)
	2) Write comments in each code					(Nic),(Gab)
	3) Tidy up code to make it more functional, Haskell-like	(Nic)
	4) Write the main function					(Gab)
   5) convection: list comprehension test on square wave (Gab)

#NEW

-- Aggiunta "relazione" con 01_specifica e 02_analisi
-- Rivedere fugoide: risultati errati
-- Nuovo paradigma per scrittura codice:

   i.   Descrivere in linguaggio naturale tutti i passi dell'algoritmo 
   ii.  Scrivere codice con commenti su "ogni" riga
   iii. Implementare una batteria ti test su Jupyter


----------------------------------------------------------------------------------------------------
Modello organizzativo progetto 

FASE I) Scrittura codice

1. Il codice da implementare viene diviso in moduli.
2. Il modulo necessario alla compilazione del programma è il /control/code/master/module/main.hs. 
3. Nel modulo main.hs verranno importati i quattro moduli necessari all'implementazione dell'algoritmo
   descritto in /relazione/03_progettazione.docx .
4. I moduli importati avranno le seguenti caratteristiche:
   -  esporteranno solo la funzione principale all'esecuzione dell'intero modulo. La sintassi è:
      module <nome_modulo>(<nome_funzi_da_esportare>) where
   -  importeranno al loro interno ulteriori sottomoduli, ciascuno dei quali dovrà implementare uno speci-
      -fico passo dell'algoritmo. La descrizione di quest'ultimo si trova in /relazione/02_analisi.docx .
5. Tutti i moduli dovranno essere meticolosamente commentati.

FASE II) Compilazione codice

1. Una volta completata l'implementazione di uno dei quattro moduli (fugoide, convezione...) si passa alla
   fase di compilazone.
2. control/set-compile.sh è lo script da eseguire con il comando source <nome_script>. All'interno dello
   script dovrà andar specificata la lista dei moduli da compilare (incluso il main) per produrre l'esegui-
   -bile.
3. Prima di ogni push è buona norma mantener pulita la propria directory di lavoro. Per questo si utilizza
   lo script control/delete_compile.sh. All'interno si deve specificare il comando "rm -r" e la relativa di-
   -recotry dove andranno rimossi i file .o e .hi .

--> Un esempio di implementazione è stato già svolto con il modello di convezione.
