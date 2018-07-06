ARG HADOOP_VERSION
FROM infotechsoft/hadoop:${HADOOP_VERSION}

ARG ACCUMULO_VERSION
ENV ACCUMULO_VERSION ${ACCUMULO_VERSION}
ENV ACCUMULO_PATH accumulo/$ACCUMULO_VERSION/accumulo-$ACCUMULO_VERSION-bin.tar.gz

RUN . /functions.sh \
    && curl -fSL "$(apache_mirror $ACCUMULO_PATH)" -o /tmp/accumulo.tar.gz \
    && curl -fSL "https://archive.apache.org/dist/$ACCUMULO_PATH.asc" -o /tmp/accumulo.tar.gz.asc \
    && curl -fSL "https://www.apache.org/dist/accumulo/KEYS" -o /tmp/KEYS \
    && gpg --no-default-keyring --keyring /tmp/keys.gpg --import /tmp/KEYS \
    && gpgv --keyring /tmp/keys.gpg /tmp/accumulo.tar.gz.asc /tmp/accumulo.tar.gz \
    && tar -xf /tmp/accumulo.tar.gz -C /opt/ \
    && rm /tmp/accumulo.tar.gz* /tmp/KEYS /tmp/keys.gpg \
    && ln -s /opt/accumulo-$ACCUMULO_VERSION /opt/accumulo \
    && cp /opt/accumulo/conf/templates/accumulo-site.xml /opt/accumulo/conf

ARG ZOOKEEPER_VERSION=3.4.12
ENV ZOOKEEPER_VERSION ${ZOOKEEPER_VERSION}
ENV ZOOKEEPER_PATH zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz

RUN . /functions.sh \
    && curl -fSL "$(apache_mirror $ZOOKEEPER_PATH)" -o /tmp/zookeeper.tar.gz \
    && curl -fSL "https://archive.apache.org/dist/$ZOOKEEPER_PATH.asc" -o /tmp/zookeeper.tar.gz.asc \
    && curl -fSL "https://www.apache.org/dist/zookeeper/KEYS" -o /tmp/KEYS \
    && gpg --no-default-keyring --keyring /tmp/keys.gpg --import /tmp/KEYS \
    && gpgv --keyring /tmp/keys.gpg /tmp/zookeeper.tar.gz.asc /tmp/zookeeper.tar.gz \
    && tar -xf /tmp/zookeeper.tar.gz -C /opt/ \
    && rm /tmp/zookeeper.tar.gz* /tmp/KEYS /tmp/keys.gpg

ADD accumulo-entrypoint.sh /accumulo-entrypoint.sh
RUN chmod a+x /accumulo-entrypoint.sh

ENV ACCUMULO_HOME /opt/accumulo-$ACCUMULO_VERSION
ENV ZOOKEEPER_HOME /opt/zookeeper-$ZOOKEEPER_VERSION

ENTRYPOINT ["/accumulo-entrypoint.sh"]
