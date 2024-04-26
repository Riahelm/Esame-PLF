#!/bin/bash

#code/master/module/main.hs -- main.hs
#code/phugoid/phugoid.hs    -- phugoid.hs
#...

ghc code/phugoid/phugoid.hs code/master/module/main.hs -o start
