#!/bin/bash

# Set some sensible defaults
export ACCUMULO_MEM_USAGE=${ACCUMULO_MEM_USAGE:-1GB}
export ACCUMULO_CONF_instance_zookeeper_host=${ACCUMULO_CONF_instance_zookeeper_host:-`hostname -f`:2181}

function addProperty() {
  local path=$1
  local name=$2
  local value=$3

  local entry="<property><name>$name</name><value>${value}</value></property>"
  local escapedEntry=$(echo $entry | sed 's/\//\\\//g')
  sed -i "/<\/configuration>/ s/.*/${escapedEntry}\n&/" $path
}

function configure() {
  local path=$1
  local module=$2
  local envPrefix=$3

  local var
  local value

  echo "Configuring $module"
  for c in `printenv | perl -sne 'print "$1 " if m/^${envPrefix}_(.+?)=.*/' -- -envPrefix=$envPrefix`; do
    name=`echo ${c} | perl -pe 's/___/-/g; s/__/_/g; s/_/./g'`
    var="${envPrefix}_${c}"
    value=${!var}
    echo " - Setting $name=$value"
    addProperty $path $name "$value"
  done
}

$ACCUMULO_HOME/bin/bootstrap_config.sh -s $ACCUMULO_MEM_USAGE -j -v 2

configure /opt/accumulo/conf/accumulo-site.xml accumulo ACCUMULO_CONF

case $1 in
    init)
        exec /entrypoint.sh /opt/accumulo/bin/accumulo init --instance-name $2 --password $3
        ;;
    *)
        exec /entrypoint.sh $@
esac
