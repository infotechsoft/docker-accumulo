Accumulo Docker
===============

A collection of Dockerfiles extending [uhopper/hadoop](https://bitbucket.org/uhopper/hadoop-docker), for creating an [Accumulo](https://accumulo.apache.org) cluster. The following Accumulo components are provided:

* monitor
* tserver
* master
* gc

All images inherit from a common base that provides hadoop, zookeeper and accumulo installations in `/opt/` and allows configuration through environment variables.

## Accumulo configuration

The *Accumulo* configuration is controlled via the following environment
variable groups:

1. `CORE_CONF`: affects `/etc/hadoop/core-site.xml`
1. `HDFS_CONF`: affects `/etc/hadoop/hdfs-site.xml`
1. `YARN_CONF`: affects `/etc/hadoop/yarn-site.xml`
1. `HTTPFS_CONF`: affects `/etc/hadoop/httpfs-site.xml`
1. `KMS_CONF`: affects `/etc/hadoop/KMS-site.xml` 
1. `ACCUMULO_CONF`: affects `/opt/accumulo/conf/accumulo-site.xml`

*Accumulo* properties are specified by setting an environment variable with the
appropriate prefix in the form `<PREFIX>_<PROPERTY>`.

Due to restrictions imposed by `docker` and `docker-compose` on
environment variable names the following substitutions are applied to
property names:

* `_` => `.`
* `__` => `_`
* `___` => `-`

Following are some illustratory examples:

* `CORE_CONF_fs_defaultFS`: sets the *fs.defaultFS* property in
`core-site.xml`
* `ACCUMULO_CONF_instance_zookeeper_host`: sets the
  *instance.zookeeper.host* property in `accumulo-site.xml`

Additionally the `ACCUMULO_MEM_USAGE` environment variable is used for bootstrapping the initial Accumulo configuration memory settings. It accepts values of `1GB`, `2GB`, `3GB`, or `512MB`.

## Dependencies

Accumulo requires running HDFS and Zookeeper instances. HDFS can be configured by following the documentation at (uhopper/hadoop)[https://hub.docker.com/r/uhopper/hadoop/], and Zookeeper using the official (zookeeper)[https://hub.docker.com/_/zookeeper/] image.
