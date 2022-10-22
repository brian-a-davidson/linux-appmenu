#!/bin/sh
#Name: appmenu_main.sh
#Purpose: Start/Stop/Status of applications
#Developer: Brian Davidson

# Get Application Name
app_name="$1"
app_upper=$(echo $app_name | awk '{print toupper($0)}')
app_lower=$(echo $app_name | awk '{print tolower($0)}')

# Get command to run
command_name="$2"
command=$(echo $command_name | awk '{print tolower($0)}')

# Get password for Remote Windows commands
pwd=$3


# Update ClearingHouse variable
if [ $app_upper = CCH ]
        then
        app_lower=clearinghouse
fi



case "$command" in

# Linux Commands

	start)
		echo "Starting $app_upper Application"
          	/opt/cts/$app_lower/tcInit.sh start
      		sleep 05; echo "done\n"
                ;;

	stop)
		echo "Stopping $app_upper Application"
           	/opt/cts/$app_lower/tcInit.sh stop
            	sleep 05; echo "done\n"
                ;;

   	status)
		echo "Checking Status of $app_upper Application"
              	/opt/cts/$app_lower/tcInit.sh status
                sleep 05; echo "done\n"
                ;;


# Windows Commands
	
	wstart)
		echo "Starting $app_upper Application"
               	echo $pwd | sudo -S /opt/cts/$app_lower/tcInit.sh start
              	sleep 05; echo "done\n"
		;;	

	wstop)
		echo "Stopping $app_upper Application"
             	echo $pwd | sudo -S /opt/cts/$app_lower/tcInit.sh stop
               	sleep 05; echo "done\n"
		;;

	wstatus)
             	echo "Checking Status of $app_upper Application"
               	echo $pwd | sudo -S /opt/cts/$app_lower/tcInit.sh status
               	sleep 05; echo "done\n"
		;;

	 *)
              	echo "USAGE: App Name [start|stop|status]"
                ;;
esac

