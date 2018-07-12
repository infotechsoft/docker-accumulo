ARG HADOOP_VERSION
FROM infotechsoft/hadoop:${HADOOP_VERSION}

ARG ACCUMULO_VERSION
ENV ACCUMULO_VERSION ${ACCUMULO_VERSION}

RUN . /functions.sh \
    && apache_install accumulo/$ACCUMULO_VERSION/accumulo-$ACCUMULO_VERSION-bin.tar.gz accumulo/KEYS \
    && ln -s /opt/accumulo-$ACCUMULO_VERSION /opt/accumulo \
    && cp /opt/accumulo/conf/templates/accumulo-site.xml /opt/accumulo/conf

ARG ZOOKEEPER_VERSION=3.4.12
ENV ZOOKEEPER_VERSION ${ZOOKEEPER_VERSION}

RUN . /functions.sh \
    && apache_install zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz zookeeper/KEYS

ADD accumulo-entrypoint.sh /accumulo-entrypoint.sh
RUN chmod a+x /accumulo-entrypoint.sh

ENV ACCUMULO_HOME /opt/accumulo-$ACCUMULO_VERSION
ENV ZOOKEEPER_HOME /opt/zookeeper-$ZOOKEEPER_VERSION

ENTRYPOINT ["/accumulo-entrypoint.sh"]
