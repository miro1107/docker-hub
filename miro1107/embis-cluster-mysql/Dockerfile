FROM my-ubuntu-16:v1

# add group and user for mysql
RUN groupadd -g 3000 mysql \
	&& useradd -u 3000 -g 3000 mysql \
	&& mkdir -p /opt/eMbis.cluster	

# set workdir
WORKDIR /opt/eMbis.cluster

# add mysql and db
ADD mysql-5.7.21.tar.gz ./servers/

#v1:含db
#ADD db_20200107.tar.gz ./sites/

#v2:改為volume連結本機,故只需建資料夾
RUN mkdir -p /opt/eMbis.cluster/sites/db

# set mysql link
RUN ln -s mysql-5.7.21/ ./servers/mysql

# set entrypoint
COPY srv.sh .

ENTRYPOINT ["./srv.sh", "mysql_start"]
EXPOSE 3306
