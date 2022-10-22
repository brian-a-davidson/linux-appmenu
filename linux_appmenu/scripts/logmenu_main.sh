#!/bin/sh
#Name: logmenu_main.sh
#Purpose: Run log, kill, dump commands
#Developer: Brian Davidson

# Get Application Name
app_name="$1"
app_upper=$(echo $app_name | awk '{print toupper($0)}')
app_lower=$(echo $app_name | awk '{print tolower($0)}')
logname=$app_name

# Get command to run
command_name="$2"
command=$(echo $command_name | awk '{print tolower($0)}')

# Get password for Remote Windows commands
pwd=$3

# Update log name for Clearinghouse
if [ "$app_lower" = cch ] 
        then
        app_lower="clearinghouse"
        logname="clearinghouse"
fi

# Get Application PID
pid=$(echo `ps -ef | grep org.apache.catalina.startup.Bootstrap | grep -i $app_lower/conf | grep -v grep | awk '{ print $2 }'`)

# Set cts directory
cts_dir=/opt/cts

# Set date variable
today_date=$(date +%Y%m%d)


## Variables for Thread Dump ##

# Verify Java directory
jdk_home=$cts_dir/jdk

if [ -d "$jdk_home" ]
	then
		jdk_home=$cts_dir/jdk
	else	
		jdk_home=$(find $cts_dir -maxdepth 1 -type d -name "jdk1.8.0_1*" | sort -n | tail -1 )
fi


# Set jstack variable
jstack="sudo -u ctsapp ${jdk_home}/bin/jstack -F"

# Set Thread dump log name
thread_dump=/tmp/thread_dump_${app_lower}_${today_date}.log




## Variables for view log ##

# Update log name for Event Collector
if [ "$app_lower" = ec ] && [[ $command =~ ^(log|wlog)$ ]]
        then
        logname="eventcollector"
fi



##  Run the selected command ##

case "$command" in

# Linux Commands

        log)
	
		# Get Catalina Base
                base=$(sed -n 's/CATALINA_BASE=//p' $cts_dir/$app_lower/install-unix.properties | tr -d '\r\n')

		# Get Application log file
                log=$(find $base -iname $logname.log -print)

		#Display log if found
		if [ -z "$log" ]
		then
			echo "Log file not found"
			sleep 2
		else
           		echo "Display $app_upper Log"
                	tail -1000 $log
                	sleep 10; echo "done\n"
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
                     		kill -9 $pid
				echo "$pid for $app_upper has been killed"
				sleep 2
                     	else
                        	echo "exiting"
                         	exit
                    	fi

   		fi
               	;;


	dump)
           	if [ -z "$pid" ] || [ -z "$jdk_home" ]
               	then
                	echo "Either the application is not running or java is not installed at /opt/cts/"
          	else
             		read -r -p "Are you sure you want to create thread dump for $app_upper process <$pid> [Y/N]:"  response
                     	if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
                 	then
				touch $thread_dump
				chown ctsapp:ctsapp $thread_dump
				chmod 755 $thread_dump
                       		$jstack $pid >> $thread_dump
                             	echo "Thread Dump file created at $thread_dump"
				sleep 2
                   	else
                        	echo "exiting"
                            	exit
                 	fi

        	fi
                ;;


# Windows Commands

        wlog)
		# Get Catalina Base
                base=$(echo $pwd | sudo -S sed -n 's/CATALINA_BASE=//p' /opt/cts/$app_lower/install-unix.properties | tr -d '\r\n')

                # Find Log File
                log=$(echo $pwd | sudo -S find $base -iname $logname.log -print)

		# Diplay log if found
		if [ -z "$log" ]
                then
                        echo "Log file not found"
                        sleep 2
                else
                        echo "Display $app_upper Log"
			echo $pwd | sudo -S tail -1000 $log
                        sleep 10; echo "done\n"
                fi
                ;;


        wkill)

                if [ -z "$pid" ]
                then
                        echo "The application is not running"
                else
               	        echo $pwd | sudo -S kill -9 $pid
                    	echo "PID $pid for $app_upper as been killed"
                       	sleep 2

                fi
                ;;


        wdump)
                if [ -z "$pid" ]
                then
                        echo "Either the application is not running or java is not installed at /opt/cts/"
                else
			echo $pwd | sudo -S echo "Generating Thread Dump"
			echo $pwd | sudo -S $jstack $pid >> $thread_dump
                       	echo "Thread Dump file created at $thread_dump"
                       	sleep 2

                fi
                ;;

esac
