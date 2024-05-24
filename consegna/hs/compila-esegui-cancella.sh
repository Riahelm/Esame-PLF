#!/bin/bash

ghc src/simulazioni_numeriche.hs -o bin/simulazioni_numeriche

rm -r src/*.{o,hi}

./bin/simulazioni_numeriche

rm -r bin/simulazioni_numeriche