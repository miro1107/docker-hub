FROM miro1107/embis-cluster-tomcat:v2

WORKDIR /opt/eMbis.cluster
COPY srv.sh .
RUN chmod 744 ./srv.sh

ENTRYPOINT ["./srv.sh", "tomcat_restart"]
