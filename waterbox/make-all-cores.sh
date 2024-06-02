#!/bin/sh
set -e

cd emulibc && make -f Makefile $1 -j && cd -
cd libco && make -f Makefile $1 -j && cd -
cd gpgx && make -f Makefile $1 -j && cd -

