#!/bin/sh

if [ $# -gt 0 ]; then
  ACCUMULO_TAG=$1
fi

if [ -z ${ACCUMULO_TAG+x} ]; then
  echo "Must define TAG enviroment variable, or pass as first argument"
  exit 1
fi

export ACCUMULO_TAG

for i in accumulo accumulo-gc accumulo-master accumulo-monitor accumulo-tserver; do
    echo Building $i
    (cd $i && ./build.sh)
done
