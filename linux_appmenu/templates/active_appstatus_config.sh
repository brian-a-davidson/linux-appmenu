#!/bin/sh
#Name: default_appstatus.conf
#Purpose: Display status of applications on the server
#Developer: Brian Davidson

##  Application List ##

#1 Application Monitor (APPMON)
appmon=no

#2 Central Device Communication Server (CDCS)
cdcs=no

#3 Clearinghouse (CCH)
cch=no

#4 Cubic Notification Gateway (CNG)
cng=no

#5 Cubic Payment Application (CPA)
cpa=no

#6 Event Collector (EC)
ec=no

#7 Nextfare Integration System (NIS)
nis=no

#8 Nextfare Central System (NCS)
ncs=yes
admc=yes

#9 Order Management System (OMS)
oms=no

#10 Product Catalog (PRODCAT)
prodcat=no

#11 Payment Abstraction Layer (PAL)
pal=no



# Start output
output="Application Status\n--------------------"


## Get Application PIDs ##

#1a Get AppMon pid
appmon_pid() {
        echo `ps -ef | grep org.apache.catalina.startup.Bootstrap | grep -i appmonitor/conf | grep -v grep | awk '{ print $2 }'`
}

#1b Get AppMon DB pid
appmondb_pid() {
        echo `ps -ef | grep org.apache.derby.drda.NetworkServerControl | grep -i appmonitor/db | grep -v grep | awk '{ print $2 }'`
}

#2 Get CDCS pid
cdcs_pid() {
        echo `ps -ef | grep org.apache.catalina.startup.Bootstrap | grep cdcs/conf | grep -v grep | awk '{ print $2 }'`
}

#3 Get CLEARINGHOUSE pid
cch_pid() {
        echo `ps -ef | grep org.apache.catalina.startup.Bootstrap | grep clearinghouse/conf | grep -v grep | awk '{ print $2 }'`
}

#4 Get CNG pid
cng_pid() {
        echo `ps -ef | grep org.apache.catalina.startup.Bootstrap | grep cng/conf | grep -v grep | awk '{ print $2 }'`
}

#5 Get CPA pid
cpa_pid() {
        echo `ps -ef | grep org.apache.catalina.startup.Bootstrap | grep cpa/conf | grep -v grep | awk '{ print $2 }'`
}

#6 Get EC pid
ec_pid() {
        echo `ps -ef | grep org.apache.catalina.startup.Bootstrap | grep ec/conf | grep -v grep | awk '{ print $2 }'`
}

#7 Get NIS pid
nis_pid() {
        echo `ps -ef | grep org.apache.catalina.startup.Bootstrap | grep nis/conf | grep -v grep | awk '{ print $2 }'`
}

#8a Get NCS Admin Console pid
admc_pid() {
        echo `ps -ef | grep /opt/bea/wlserver/ | grep AdminServer | awk '{ print $2 }'`
}

#8b Get Node Manager pid
nmgr_pid() {
        echo `ps -ef | grep /opt/bea/wlserver/ | grep weblogic.NodeManager | awk '{ print $2 }'`
}

#8c Get NCS Application pid
ncs_pid() {
       echo `ps -ef | grep /opt/bea/wlserver/ | grep weblogic.Server | grep -v AdminServer | awk '{ print $2 }'`
}

#9 Get OMS pid
oms_pid() {
        echo `ps -ef | grep org.apache.catalina.startup.Bootstrap | grep oms/conf | grep -v grep | awk '{ print $2 }'`
}

#10 Get PRODCAT pid
prodcat_pid() {
        echo `ps -ef | grep org.apache.catalina.startup.Bootstrap | grep prodcat/conf | grep -v grep | awk '{ print $2 }'`
}

#11 Get PAL pid
pal_pid() {
        echo `ps -ef | grep org.apache.catalina.startup.Bootstrap | grep pal/conf | grep -v grep | awk '{ print $2 }'`
}




##  Cofirm UP/Down status for Applications ##

#1a Check AppMon
if [ $appmon = "yes" ]
	then
		if [ -n "$(appmon_pid)" ]
        	then
                	output="$output \nAppMon \t\t- UP"
        	else
                	output="$output  \nAppMon \t\t- DOWN"
	fi
fi


#1b Check AppMon Database
if [ $appmon = "yes" ]
	then
		if [ -n "$(appmondb_pid)" ]
        	then
                	output="$output \nAppMon-DB \t- UP"
        	else
                	output="$output  \nAppMon-DB \t- DOWN"
	fi
fi


#2 Check CDCS
if [ $cdcs = "yes" ]
        then
		if [ -n "$(cdcs_pid)" ]
        	then
                	output="$output \nCDCS \t\t- UP"
        	else
                	output="$output  \nCDCS \t\t- DOWN"
	fi
fi

#3 Check CLEARINGHOUSE
if [ $cch = "yes" ]
        then
		if [ -n "$(cch_pid)" ]
        	then
                	output="$output \nCLEARINGHOUSE \t- UP"
        	else
                	output="$output  \nCLEARINGHOUSE \t- DOWN"
	fi
fi


#4 Check CNG
if [ $cng = "yes" ]
        then
		if [ -n "$(cng_pid)" ]
        	then
                	output="$output \nCNG \t\t- UP"
        	else
                	output="$output  \nCNG \t\t- DOWN"
	fi
fi


#5 Check CPA
if [ $cpa = "yes" ]
        then
		if [ -n "$(cpa_pid)" ]
        	then
                	output="$output \nCPA \t\t- UP"
        	else
                	output="$output  \nCPA \t\t- DOWN"
	fi
fi


#6 Check EC
if [ $ec = "yes" ]
        then
		if [ -n "$(ec_pid)" ]
        	then
                	output="$output \nEC \t\t- UP"
        	else
                	output="$output  \nEC \t\t- DOWN"
	fi
fi


#7 Check NIS
if [ $nis = "yes" ]
        then
		if [ -n "$(nis_pid)" ]
        	then
                	output="$output \nNIS \t\t- UP"
        	else
                	output="$output  \nNIS \t\t- DOWN"
	fi
fi


#8a Check NCS Admin Console
if [ $admc = "yes" ]
        then
        	if [ -n "$(admc_pid)" ]
                then
                        output="$output \nAdmin Console \t- UP"

                else
                        output="$output  \nAdmin Console \t- DOWN"
        	fi
fi


#8b Check NCS Node Manager
if [ $ncs = "yes" ]
        then
        	if [ -n "$(nmgr_pid)" ]
                then
               		output="$output \nNode Manager \t- UP"
                else
                        output="$output  \nNode Manager \t- DOWN"
        fi
fi


#8c Check NCS Application
if [ $ncs = "yes" ]
        then
        if [ -n "$(ncs_pid)" ]
                then
                        output="$output \nNCS \t\t- UP"
                else
                        output="$output  \nNCS \t\t- DOWN"
        fi
fi

#9 Check OMS
if [ $oms = "yes" ]
        then
	if [ -n "$(oms_pid)" ]
        	then
                	output="$output \nOMS \t\t- UP"
        	else
                	output="$output  \nOMS \t\t- DOWN"
	fi
fi

#10 Check PRODCAT
if [ $prodcat = "yes" ]
        then
		if [ -n "$(prodcat_pid)" ]
        	then
                	output="$output \nPRODCAT \t- UP"
        	else
                	output="$output  \nPRODCAT \t- DOWN"
	fi
fi

#11 Check PAL
if [ $pal = "yes" ]
        then
		if [ -n "$(pal_pid)" ]
        	then
                	output="$output \nPAL \t\t- UP"
        	else
                	output="$output  \nPAL \t\t- DOWN"
	fi
fi


# Display output
echo -e $output
sleep 5

