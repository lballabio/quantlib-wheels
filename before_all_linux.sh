#!/bin/bash
set -e

# Setup Boost
curl -O -L https://archives.boost.io/release/1.88.0/source/boost_1_88_0.tar.gz
tar xfz boost_*.tar.gz
cd boost_*/
mv boost /usr/local/include/
cd ..

# Build QuantLib
cd QuantLib-1.*/
./configure --disable-static --disable-test-suite --enable-skip-examples --enable-unity-build CXXFLAGS="${CXXQLFLAGS}"
make -j 4 install
cd ..
