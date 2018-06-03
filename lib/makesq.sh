#!/bin/sh

mkdir -p ~/vm/d && \
cd c && make clean && make && \
cd ../cpp && make clean && make && \
cp *.so ~/vm/d/. && cd .. && \
                                 \
cd c && make M32=-m32 clean && make M32=-m32 && \
cd ../cpp && make M32=-m32 clean && make M32=-m32 && \
cp *.so ~/vm/d/. && cd .. && \
                            \
cd c && ./makewin.sh && \
cd ../cpp && ./makewin.sh && \
cd .. && \
                                 \
cd c && ./makewin32.sh && \
cd ../cpp && ./makewin32.sh && \
cd ..

