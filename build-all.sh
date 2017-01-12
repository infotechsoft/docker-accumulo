#!/bin/sh

for i in accumulo accumulo-gc accumulo-master accumulo-monitor accumulo-tserver; do
    echo Building $i
    (cd $i && ./build.sh)
done
