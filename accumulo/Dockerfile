ARG HADOOP_VERSION
FROM infotechsoft/hadoop:$HADOOP_VERSION

RUN curl -fSL https://archive.apache.org/dist/accumulo/KEYS -o /tmp/KEYS \
    && gpg --import /tmp/KEYS \
    && rm /tmp/KEYS

ARG ACCUMULO_VERSION
ENV ACCUMULO_VERSION $ACCUMULO_VERSION
ENV ACCUMULO_URL https://archive.apache.org/dist/accumulo/$ACCUMULO_VERSION/accumulo-$ACCUMULO_VERSION-bin.tar.gz

RUN set -x \
    && curl -fSL "$ACCUMULO_URL" -o /tmp/accumulo.tar.gz \
    && curl -fSL "$ACCUMULO_URL.asc" -o /tmp/accumulo.tar.gz.asc \
    && gpg --verify /tmp/accumulo.tar.gz.asc /tmp/accumulo.tar.gz \
    && tar -xf /tmp/accumulo.tar.gz -C /opt/ \
    && rm /tmp/accumulo.tar.gz* \
    && ln -s /opt/accumulo-$ACCUMULO_VERSION /opt/accumulo

RUN curl -fSL https://archive.apache.org/dist/zookeeper/KEYS -o /tmp/KEYS \
    && gpg --import /tmp/KEYS \
    && rm /tmp/KEYS

ARG ZOOKEEPER_VERSION=3.4.12
ENV ZOOKEEPER_VERSION ${ZOOKEEPER_VERSION}
ENV ZOOKEEPER_URL http://apache.org/dist/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz

RUN set -x \
    && curl -fSL "$ZOOKEEPER_URL" -o /tmp/zookeeper.tar.gz \
    && curl -fSL "$ZOOKEEPER_URL.asc" -o /tmp/zookeeper.tar.gz.asc \
    && gpg --verify /tmp/zookeeper.tar.gz.asc /tmp/zookeeper.tar.gz \
    && tar -xf /tmp/zookeeper.tar.gz -C /opt/ \
    && rm /tmp/zookeeper.tar.gz*

ADD accumulo-entrypoint.sh /accumulo-entrypoint.sh
RUN chmod a+x /accumulo-entrypoint.sh

ENV ACCUMULO_HOME /opt/accumulo-$ACCUMULO_VERSION
ENV ZOOKEEPER_HOME /opt/zookeeper-$ZOOKEEPER_VERSION

ENTRYPOINT ["/accumulo-entrypoint.sh"]
