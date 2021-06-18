#!/usr/bin/env bash

### BEGIN INIT INFO
# Provides:          eMbis
# Required-Start:    $local_fs $network
# Required-Stop:     $local_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: eMbis Cluster start script.
# Description:       Starting Apache Tomcat Mysql under /opt/eMbis
### END INIT INFO


#platform root
SERVERS_ROOT="/opt/eMbis.cluster/servers"

#config for JAVA_HOME enviroment
JAVA_HOME=$SERVERS_ROOT/jdk
JRE_HOME=$JAVA_HOME/jre
CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib
PATH=$JAVA_HOME/bin:$PATH

#config for TOMCAT_HOME enviroment
TOMCAT_HOME=$SERVERS_ROOT/tomcat

#啟動或關閉mysql, 參數1: {start|stop}
funcMysql() {
    if [ "$1" = "start" ]
    then
        echo "=========="
        echo "Mysql start..."
		#刪除之前的pid跟err
		rm -rf /opt/eMbis.cluster/sites/db/*.pid
		rm -rf /opt/eMbis.cluster/sites/db/*.err
		#修改db目錄權限
		chown -R mysql:mysql /opt/eMbis.cluster/sites/db
        $SERVERS_ROOT/mysql/support-files/mysql.server start --bind-address=0.0.0.0 --character_set_server=utf8		
        echo "...done"
        echo "=========="
        echo " "
		#tail為讓docker一直執行
		tail -f /opt/eMbis.cluster/sites/db/$(hostname).err
    elif [ "$1" = "stop" ]
    then
        echo "=========="
        echo "Mysql stop..."        
        $SERVERS_ROOT/mysql/support-files/mysql.server stop
        echo "...done"
        echo "=========="
        echo " "
    fi
}

#啟動或關閉apache, 參數1: {start|stop}
funcApache() {
    if [ "$1" = "start" ]
    then
        echo "=========="
        echo "Apache start..."
        $SERVERS_ROOT/apache/http-2.4.29/bin/apachectl start
        echo "...done"
        echo "=========="
        echo " "
    elif [ "$1" = "stop" ]
    then
        echo "=========="
        echo "Apache stop..."        
        $SERVERS_ROOT/apache/http-2.4.29/bin/apachectl stop
        echo "...done"
        echo "=========="
        echo " "
    fi
}

#啟動或關閉tomcat, 參數1: {start|stop}
funcTomcat() {
    pidlist=`ps -ef|grep java|grep tomcat|grep -v grep|awk '{print $2}'`
    
    if [ "$1" = "start" ]
    then
        echo "=========="
        if [ "$pidlist" = "" ]
        then
            echo "Tomcat start..."
            
            # 刪除超過30天的log
            find $TOMCAT_HOME/logs/ -mtime +30 -exec rm -rf {} \;

            # 以防logs目錄被刪除
            mkdir -p $TOMCAT_HOME/logs             
            
            #將舊的log存起來
            mv $TOMCAT_HOME/logs/catalina.out $TOMCAT_HOME/logs/catalina.out".`date +%Y%m%d%H%M%S`"
            mv $TOMCAT_HOME/logs/apismgr.log $TOMCAT_HOME/logs/apismgr.log".`date +%Y%m%d%H%M%S`"
            sleep 2
            
            #startup.sh
            $TOMCAT_HOME/bin/startup.sh
			
            echo "...done"
			
			#tail為讓docker一直執行
			tail -f $TOMCAT_HOME/logs/catalina.out
            
        else
            echo "Tomcat is running, Please stop first!"
        fi    
        echo "=========="
        echo " "
    elif [ "$1" = "stop" ]
    then
        echo "=========="
        #$TOMCAT_HOME/bin/shutdown.sh   #因怕卡住,故不直接使用shutdown.sh
        #if [ "$pidlist" = "" ]
        #then
        #    echo "Tomcat haven't startup!"
        #else
            echo "Tomcat stop..."
            #刪除tomcat的pid
            for pid in $pidlist
            do
                kill -9 $pid
                echo "kill -9 $pid"
            done
            sleep 2
            
            #清空tmp
            rm -rf $TOMCAT_HOME/work/Catalina/localhost/*
            rm -rf $TOMCAT_HOME/temp/*
            #temp file
            rm -rf /opt/eMbis.cluster/sites/files/temp/*

            echo "...done"
        #fi
        echo "=========="
        echo " "
    fi
}

case "$1" in
    mysql_start)
        funcMysql start
        ;;
    mysql_stop)
        funcMysql stop
        ;;
    mysql_restart)
        $0 mysql_stop
        sleep 2
        $0 mysql_start
        ;;
    apache_start)
        funcApache start
        ;;
    apache_stop)
        funcApache stop
        ;;
    apache_restart)
        $0 apache_stop
        sleep 2
        $0 apache_start
        ;;
    tomcat_start)
        funcTomcat start
        ;;
    tomcat_stop)
        funcTomcat stop
        ;;
    tomcat_restart)
        $0 tomcat_stop
        sleep 2
        $0 tomcat_start
        ;;
    start)
        funcMysql start
        funcTomcat start
        funcApache start
        ;;
    stop)
        funcApache stop
        funcTomcat stop
        funcMysql stop
        ;;    
    restart)
        $0 stop
        sleep 2
        $0 start
        ;;
    force-reload)
        $0 stop
        sleep 2
        $0 start
        ;;

    *)
        echo "Wrong parameters!"
        ;;
esac