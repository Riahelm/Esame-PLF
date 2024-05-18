/* Predicato per il conteggio degli elementi di una lista */
conta([],N,N).
conta([_|LX],N,I) :- I1 is N + 1,
                     conta(LX,I1,I).
