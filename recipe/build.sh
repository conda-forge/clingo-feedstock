#!/bin/bash

set -x

mkdir build
cd build

env

if [[  "${CONDA_BUILD_CROSS_COMPILATION}" == "1" && "${python_impl}" == "pypy" ]]; then
    cmake ${CMAKE_ARGS} .. \
        -DPython_FIND_STRATEGY="LOCATION" \
        -DPython_ROOT_DIR="${PREFIX}" \
        -DPython_INCLUDE_DIR="${PREFIX}/include/${python_impl}${PY_VER}" \
        -DCLINGO_BUILD_WITH_PYTHON=ON \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
        -DPYCLINGO_INSTALL_DIR="${SP_DIR}" \
        -DCLINGO_BUILD_WITH_LUA=OFF \
        -DCLINGO_MANAGE_RPATH=OFF \
        -DCMAKE_INSTALL_LIBDIR="lib" \
        -DCMAKE_BUILD_TYPE=Release
else
    cmake ${CMAKE_ARGS} .. \
        -DPython_FIND_STRATEGY="LOCATION" \
        -DPython_ROOT_DIR=${PREFIX} \
        -DCLINGO_BUILD_WITH_PYTHON=ON \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
        -DPYCLINGO_INSTALL_DIR="${SP_DIR}" \
        -DCLINGO_BUILD_WITH_LUA=OFF \
        -DCLINGO_MANAGE_RPATH=OFF \
        -DCMAKE_INSTALL_LIBDIR="lib" \
        -DCMAKE_BUILD_TYPE=Release
fi

make VERBOSE=1 -j${CPU_COUNT}
make install

