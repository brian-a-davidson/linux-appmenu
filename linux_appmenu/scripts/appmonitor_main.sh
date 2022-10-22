#!/bin/sh
#Name: appmonitor_main.sh
#Purpose: Start/Stop/Status for AppMonitor
#Developer: Brian Davidson

# Get Application Name
app_name="$1"
app_upper=$(echo $app_name | awk '{print toupper($0)}')
app_lower=$(echo $app_name | awk '{print tolower($0)}')

# Get command to run
command="$2"


# Get AppMon PID
appmon_pid() {
        echo `ps -ef | grep org.apache.catalina.startup.Bootstrap | grep -i appmonitor/conf | grep -v grep | awk '{ print $2 }'`
}

# Get AppMon DB pid
appmondb_pid() {
        echo `ps -ef | grep org.apache.derby.drda.NetworkServerControl | grep -i appmonitor/db | grep -v grep | awk '{ print $2 }'`
}

case "$command" in


# Linux Commands for Appmon Application

        start_appmon)
                echo "Starting $app_upper Application"
                /opt/cts/appMonitor/tcInit.sh start
                sleep 05; echo "done\n"
                ;;

        stop_appmon)
                echo "Stopping $app_upper Application"
                /opt/cts/appMonitor/tcInit.sh stop
                sleep 05; echo "done\n"
                ;;

        status_appmon)
                echo "Checking Status of $app_upper Application"
                pid=$(appmon_pid)
                if [ -n $pid ]
                        then
                                echo "Tomcat is running with pid: $pid "
                        else
                                echo "Tomcat is not running"
                fi
                sleep 05; echo "done\n"
                ;;



# Linux Commands for Appmon Database

        start_appmondb)
                echo "Starting $app_upper Application"
                /opt/cts/appMonitor/tcInitDb.sh start
                sleep 05; echo "done\n"
                ;;

        stop_appmondb)
                echo "Stopping $app_upper Application"
                /opt/cts/appMonitor/tcInitDb.sh stop
                sleep 05; echo "done\n"
                ;;

        status_appmondb)
                echo "Checking Status of $app_upper Application"
                pid=$(appmondb_pid)
                if [ -n $pid ]
                        then
                                echo "Tomcat is running with pid: $pid "
                        else
                                echo "Tomcat is not running"
                fi
                sleep 05; echo "done\n"
                ;;
esac
