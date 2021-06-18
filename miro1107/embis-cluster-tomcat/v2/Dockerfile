FROM my-ubuntu-16:v2

# make and set workdir
RUN mkdir -p /opt/eMbis.cluster	
WORKDIR /opt/eMbis.cluster

# add jdk and tomcat
ADD jdk1.7.0_80.tar.gz ./servers/
ADD apache-tomcat-7.0.77.tar.gz ./servers

#v1:含apis; files在啟動時會自動產生
#ADD apis_20200109.tar.gz ./sites/

#v2:改為volume連結本機,故只需建資料夾
RUN mkdir -p /opt/eMbis.cluster/sites/apis \
	&& mkdir -p /opt/eMbis.cluster/sites/files

# set java and tomcat link
RUN ln -s jdk1.7.0_80/ ./servers/jdk \
	&& ln -s apache-tomcat-7.0.77/ ./servers/tomcat

# set entrypoint
COPY srv.sh .

ENTRYPOINT ["./srv.sh", "tomcat_restart"]
EXPOSE 8009 8080 8443
