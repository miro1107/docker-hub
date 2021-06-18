FROM ubuntu:16.04

# change local and timezone
ENV TZ Asia/Chongqing
RUN apt-get update \
	&& apt-get install -y --no-install-recommends locales tzdata \
	&& rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
	&& ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
	&& dpkg-reconfigure --frontend noninteractive tzdata
ENV LANG en_US.utf8

# install vi(vim), ping(iputils-ping), netstat+ifconfig(net-tools)
RUN apt-get update \
	&& apt-get install -y --no-install-recommends vim iputils-ping net-tools