#!/bin/bash

# Set some sensible defaults
export ACCUMULO_MEM_USAGE=${ACCUMULO_MEM_USAGE:-1GB}
export ACCUMULO_CONF_instance_zookeeper_host=${ACCUMULO_CONF_instance_zookeeper_host:-`hostname -f`:2181}

source /functions.sh

$ACCUMULO_HOME/bin/bootstrap_config.sh -s $ACCUMULO_MEM_USAGE -j -v 2

configure /opt/accumulo/conf/accumulo-site.xml accumulo ACCUMULO_CONF

case $1 in
    init)
        exec /entrypoint.sh /opt/accumulo/bin/accumulo init --instance-name $2 --password $3
        ;;
    shell)
        exec /entrypoint.sh /opt/accumulo/bin/accumulo shell -u $2
        ;;
    *)
        exec /entrypoint.sh $@
esac
