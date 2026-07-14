#! /usr/bin/bash
set -e

sed -i "s|FC = gfortran|FC = ${FC}|g" Config
sed -i "s|FFLAGS = -O|FFLAGS = ${FFLAGS}|g" Config

# create.py hardcodes Linux's `-shared`/.so for the dynamic-library step;
# macOS needs `-dynamiclib`/.dylib (SHLIB_EXT), or the link step silently
# fails and the `mv` below can't find libavh_olo${SHLIB_EXT}.
if [ "$(uname)" = "Darwin" ]; then
  sed -i.bak "s/'-shared'/'-dynamiclib'/; s/libavh_olo\.so/libavh_olo${SHLIB_EXT}/" create.py
fi

python create.py dynamic

mkdir -p "${PREFIX}/include/oneloop"
mv *.mod "${PREFIX}/include/oneloop/"
mv "libavh_olo${SHLIB_EXT}" "${PREFIX}/lib/"
./clean.sh
