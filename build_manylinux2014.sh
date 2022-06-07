#!/bin/bash

# Setup Boost
curl -O -L https://boostorg.jfrog.io/artifactory/main/release/1.79.0/source/boost_1_79_0.tar.gz
tar xfz boost_1_79_0.tar.gz
cd boost_1_79_0
mv boost /usr/local/include/
cd ..

# Build QuantLib
tar xfz QuantLib-1.*.tar.gz
cd QuantLib-1.*/
./configure --disable-static --enable-unity-build CXXFLAGS="-O3 -g0"
make -j 4 install
cd ..
ldconfig

# Build QuantLib wheels

tar xfz QuantLib-SWIG-1.*.tar.gz
cd QuantLib-SWIG-1.*/Python
CXXFLAGS='-O3 -g0' /opt/python/pp39-pypy39_pp73/bin/pypy setup.py bdist_wheel
rm -rf build/
for i in dist/*.whl ; do auditwheel repair $i ; done
cd ../..

# Test wheels
rm -rf /usr/local/lib/libQuantLib*
/opt/python/pp39-pypy39_pp73/bin/pypy -m pip install --no-index --find-links QuantLib-SWIG-1.*/Python/wheelhouse/ QuantLib
/opt/python/pp39-pypy39_pp73/bin/pypy QuantLib-SWIG-*/Python/test/QuantLibTestSuite.py

