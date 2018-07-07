ARG HADOOP_VERSION
ARG ACCUMULO_VERSION
FROM infotechsoft/accumulo:${HADOOP_VERSION}-${ACCUMULO_VERSION}

EXPOSE 9995

CMD ["/opt/accumulo/bin/accumulo", "monitor"]
