FROM miro1107/embis-cluster-tomcat:v1

WORKDIR /opt/eMbis.cluster
COPY srv.sh .
RUN chmod 744 ./srv.sh

ENTRYPOINT ["./srv.sh", "tomcat_restart"]
