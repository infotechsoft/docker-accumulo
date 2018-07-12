#!/bin/sh
set -e

if [ $# -gt 0 ]; then
    HADOOP_VERSION=$1
    if [ $# -gt 1 ]; then
        ACCUMULO_VERSION=$2
    fi
fi

if [ -z ${HADOOP_VERSION+x} ]; then
  echo "Must define HADOOP_VERSION enviroment variable, or pass as first argument"
  exit 1
fi

if [ -z ${ACCUMULO_VERSION+x} ]; then
    echo "Must defin ACCUMULO_VERSION environment variable or pass as second argument"
    exit 1
fi

ACCUMULO_TAG=$HADOOP_VERSION-$ACCUMULO_VERSION

for i in accumulo accumulo-gc accumulo-master accumulo-monitor accumulo-tserver; do
    echo Building $i
    ( cd $i && docker build --build-arg HADOOP_VERSION=$HADOOP_VERSION \
        --build-arg ACCUMULO_VERSION=$ACCUMULO_VERSION \
        --build-arg ACCUMULO_TAG=$ACCUMULO_TAG \
        -t infotechsoft/$i:$ACCUMULO_TAG . )
done
