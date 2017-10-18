#!/bin/sh

if [ $# -gt 0 ]; then
  ACCUMULO_TAG=$1
fi

if [ -z ${ACCUMULO_TAG+x} ]; then
  echo "Must define TAG enviroment variable, or pass as first argument"
  exit 1
fi

docker build -t infotechsoft/accumulo-gc:$ACCUMULO_TAG .
