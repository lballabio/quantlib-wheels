#!/bin/bash

# Setup Boost
curl -O -L https://boostorg.jfrog.io/artifactory/main/release/1.80.0/source/boost_1_80_0.tar.gz
tar xfz boost_1_80_0.tar.gz
cd boost_1_80_0
# this fails the configure check and avoids compiling the test suite
rm boost/test/included/unit_test.hpp
mv boost /usr/local/include/
cd ..

# Build QuantLib
cd QuantLib-1.*/
./configure --disable-static --enable-unity-build CXXFLAGS="-O3 -g0"
make -j 4
cd ..
