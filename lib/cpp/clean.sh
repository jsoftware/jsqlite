#!/bin/bash

export LC_ALL=en_US.UTF-8

rm -f *.o *.obj *.gch

if [ ! -f /usr/bin/astyle ]; then exit 0; fi

f() {
 /usr/bin/astyle \
  --style=linux \
  --indent=spaces=2 \
  --suffix=none \
  --pad-header \
  --unpad-paren \
  --quiet \
  "$1"
}

for m in *.cpp; do
  f "$m"
done;

