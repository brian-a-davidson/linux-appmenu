#!/bin/sh
#Name: ncs_main.sh
#Purpose: Run commands for NCS
#Developer: Brian Davidson

# Get Application Name
app_name="$1"
app_upper=$(echo $app_name | awk '{print toupper($0)}')
app_lower=$(echo $app_name | awk '{print tolower($0)}')

# Get command to run
command="$2"

admc_pid=$(echo `ps -ef | grep /opt/bea/wlserver/ | grep AdminServer | awk '{ print $2 }'`)
nmgr_pid=$(echo `ps -ef | grep /opt/bea/wlserver/ | grep weblogic.NodeManager | awk '{ print $2 }'`)
ncs_pid=$(echo `ps -ef | grep /opt/bea/wlserver/ | grep weblogic.Server | grep -v AdminServer | awk '{ print $2 }'`)


# Check NCS
if [ $app_lower = ncs ]
        then
        pid=$ncs_pid
fi

# Check Node Manager
if [ $app_lower = nmgr ]
        then
        pid=$nmgr_pid
fi

# Check Admin Console
if [ $app_lower = admc ]
        then
        pid=$admc_pid
fi




case "$command" in


# Linux Commands for NCS Application

	status)
        	if [ -z "$pid" ]
                then
                	echo "The application is not running"
              	else
                  	echo "The $app_upper application is running with the following PID: $pid "
                       	sleep 05; echo "done\n"
		fi		
		;;


        kill)
		if [ -z "$pid" ]
		then
			echo "The application is not running"
		else
			read -r -p "Are you sure you want to kill the following $app_upper process <$pid> [Y/N]:"  response
				if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]	
				then
                                        echo "The $app_upper application is running with the following PID: $pid "
                                        kill -9 $pid
                                        echo "The PID: $pid has been killed for $app_upper"
                                        sleep 05; echo "done\n"
                                else
                                        echo "exiting"
                                        exit
                                fi
		fi			
		;;

        start_admc)
		echo "Starting Weblogic Admin Console"
                /opt/bea/ncs/wlAdminInit.sh start
                sleep 05; echo "done\n"
                ;;


	start_nmgr)
		echo "Starting Node Manager"
                /opt/bea/ncs/wlNodeMgrInit.sh start
                sleep 05; echo "done\n"
                ;;

esac
