#!/bin/bash
set -e

# Setup Boost
curl -O -L https://boostorg.jfrog.io/artifactory/main/release/1.81.0/source/boost_1_81_0.tar.gz
tar xfz boost_*.tar.gz
cd boost_*/
mv boost /usr/local/include/
cd ..

# Build QuantLib
cd QuantLib-1.*/
./configure --disable-static --disable-test-suite --enable-unity-build CXXFLAGS="-O3 -g0"
make -j 4 install
cd ..
