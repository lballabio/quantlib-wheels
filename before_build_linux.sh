#!/bin/bash

# Setup Boost
cd boost_1_80_0
mv boost /usr/local/include/
cd ..

# Install QuantLib
cd QuantLib-1.*/
make -j 4 install
cd ..
