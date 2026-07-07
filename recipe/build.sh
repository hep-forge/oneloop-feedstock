#! /usr/bin/bash
set -e

sed -i "s|FC = gfortran|FC = ${FC}|g" Config
sed -i "s|FFLAGS = -O|FFLAGS = ${FFLAGS}|g" Config

python create.py dynamic

mkdir -p "${PREFIX}/include/oneloop"
mv *.mod "${PREFIX}/include/oneloop/"
mv "libavh_olo${SHLIB_EXT}" "${PREFIX}/lib/"
./clean.sh
