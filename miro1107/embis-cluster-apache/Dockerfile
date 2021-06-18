FROM my-ubuntu-16:v2

# make and set workdir
RUN mkdir -p /opt/eMbis.cluster	
WORKDIR /opt/eMbis.cluster

# add apache
ADD apache-2.4.29.tar.gz ./servers/

#v1:含sites在啟動時會自動產生
#ADD sites_20200109.tar.gz ./sites/

#v2:改為volume連結本機,故只需建資料夾
RUN mkdir -p /opt/eMbis.cluster/sites/web \
	&& mkdir -p /opt/eMbis.cluster/sites/admin \
	&& mkdir -p /opt/eMbis.cluster/sites/pb

# set apache link
RUN ln -s apache-2.4.29/ ./servers/apache

# set entrypoint
COPY srv.sh .

ENTRYPOINT ["./srv.sh", "apache_start"]
EXPOSE 80 443
