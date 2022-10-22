#!/bin/sh
# Name: deploy_cts_appmenu.sh 
# Version: 2.0
# Purpose: Deploy the CTS Appmenu 
# Developer: Brian Davidson


# Set Colors
red='\e[0;31m'
yellow='\e[33;40m'
white='\e[37;40m'
NC='\e[0m' # No Color


# Get Environment name from user
read -r -p "Which environment do you want to setup the CTS Appmenu for? (test/stage/production):"  env_name
env_upper=$(echo $env_name | awk '{print toupper($0)}')


echo -e "\nNote: This script can be ran again if the configuration is not setup correctly the first time"
read -r -p "Would you like to select the applications running on this server manually or automatically [pick M or A]:" deploy_method
deploy_lower=$(echo $deploy_method | awk '{print tolower($0)}')

if [ "$deploy_lower" = m ] || [ "$deploy_lower" = a ]
	then
		deploy=yes
	else
		echo "$deploy_method not a valid selection. Please rerun the script and pick either M or A"
		exit
fi

# CTS directory
cts_dir="/opt/cts"

# BEA directory
bea_dir="/opt/bea"

# Create Appstatus configuration from template
default_appstatus=/opt/cubic_appmenu/templates/default_appstatus.conf
active_appstatus=/opt/cubic_appmenu/templates/active_appstatus_config.sh
cat $default_appstatus > $active_appstatus



case "$deploy_lower" in

# Automatically Configure
a)

echo -e "${yellow}The following applications were found on this server and will be added to the CTS Appmenu ${NC}"

#1 Check if Application Monitor (APPMON) is installed
if [ -d "$cts_dir/appMonitor" ]
        then
                        appmon_installed="yes"
                        appmon_current_value=$(sed -n 's/appmon=//p' $active_appstatus)
			echo -e "appmon installed = $appmon_installed"
                        sed -i "s/appmon=$appmon_current_value/appmon=$appmon_installed/g" $active_appstatus
                        appmon=$(sed -n 's/appmon=//p' $active_appstatus)
        else
                        appmon_installed="no"
                        appmon_current_value=$(sed -n 's/appmon=//p' $active_appstatus)
			echo -e "appmon installed = $appmon_installed"
                        sed -i "s/appmon=$appmon_current_value/appmon=$appmon_installed/g" $active_appstatus
                        appmon=$(sed -n 's/appmon=//p' $active_appstatus)
fi


#2 Check if Central Device Communication Server (CDCS) is installed
if [ -d "$cts_dir/cdcs" ]
        then
			cdcs_installed="yes"
			cdcs_current_value=$(sed -n 's/cdcs=//p' $active_appstatus)
			echo -e "cdcs installed = $cdcs_installed"
			sed -i "s/cdcs=$cdcs_current_value/cdcs=$cdcs_installed/g" $active_appstatus
			cdcs=$(sed -n 's/cdcs=//p' $active_appstatus)
	else
			cdcs_installed="no"
                        cdcs_current_value=$(sed -n 's/cdcs=//p' $active_appstatus)
                        echo -e "cdcs installed = $cdcs_installed"
                        sed -i "s/cdcs=$cdcs_current_value/cdcs=$cdcs_installed/g" $active_appstatus
                        cdcs=$(sed -n 's/cdcs=//p' $active_appstatus)
fi


#3 Check if Clearinghouse (CCH) is installed
if [ -d "$cts_dir/clearinghouse" ]
        then
                        cch_installed="yes"
                        cch_current_value=$(sed -n 's/cch=//p' $active_appstatus)
                        echo -e "cch installed = $cch_installed"
                        sed -i "s/cch=$cch_current_value/cch=$cch_installed/g" $active_appstatus
                        cch=$(sed -n 's/cch=//p' $active_appstatus)
        else
                        cch_installed="no"
                        cch_current_value=$(sed -n 's/cch=//p' $active_appstatus)
                        echo -e "cch installed = $cch_installed"
                        sed -i "s/cch=$cch_current_value/cch=$cch_installed/g" $active_appstatus
                        cch=$(sed -n 's/cch=//p' $active_appstatus)
fi


#4 Check if Cubic Notification Gateway (CNG) is installed
if [ -d "$cts_dir/cng" ]
        then
                        cng_installed="yes"
                        cng_current_value=$(sed -n 's/cng=//p' $active_appstatus)
                        echo -e "cng installed = $cng_installed"
                        sed -i "s/cng=$cng_current_value/cng=$cng_installed/g" $active_appstatus
                        cng=$(sed -n 's/cng=//p' $active_appstatus)
        else
                        cng_installed="no"
                        cng_current_value=$(sed -n 's/cng=//p' $active_appstatus)
                        echo -e "cng installed = $cng_installed"
                        sed -i "s/cng=$cng_current_value/cng=$cng_installed/g" $active_appstatus
                        cng=$(sed -n 's/cng=//p' $active_appstatus)
fi

#5 Check if Cubic Payment Application (CPA) is installed
if [ -d "$cts_dir/cpa" ]
        then
                        cpa_installed="yes"
                        cpa_current_value=$(sed -n 's/cpa=//p' $active_appstatus)
                        echo -e "cpa installed = $cpa_installed"
                        sed -i "s/cpa=$cpa_current_value/cpa=$cpa_installed/g" $active_appstatus
                        cpa=$(sed -n 's/cpa=//p' $active_appstatus)
        else
                        cpa_installed="no"
                        cpa_current_value=$(sed -n 's/cpa=//p' $active_appstatus)
                        echo -e "cpa installed = $cpa_installed"
                        sed -i "s/cpa=$cpa_current_value/cpa=$cpa_installed/g" $active_appstatus
                        cpa=$(sed -n 's/cpa=//p' $active_appstatus)
fi


#6 Check if Event Collector (EC) is installed
if [ -d "$cts_dir/ec" ]
        then
                        ec_installed="yes"
                        ec_current_value=$(sed -n 's/ec=//p' $active_appstatus)
                        echo -e "ec installed = $ec_installed"
                        sed -i "s/ec=$ec_current_value/ec=$ec_installed/g" $active_appstatus
                        ec=$(sed -n 's/ec=//p' $active_appstatus)
        else
                        ec_installed="no"
                        ec_current_value=$(sed -n 's/ec=//p' $active_appstatus)
                        echo -e "ec installed = $ec_installed"
                        sed -i "s/ec=$ec_current_value/ec=$ec_installed/g" $active_appstatus
                        ec=$(sed -n 's/ec=//p' $active_appstatus)
fi


#7 Check if Nextfare Integration System (NIS) is installed
if [ -d "$cts_dir/nis" ]
        then
                        nis_installed="yes"
                        nis_current_value=$(sed -n 's/nis=//p' $active_appstatus)
                        echo -e "nis installed = $nis_installed"
                        sed -i "s/nis=$nis_current_value/nis=$nis_installed/g" $active_appstatus
                        nis=$(sed -n 's/nis=//p' $active_appstatus)
        else
                        nis_installed="no"
                        nis_current_value=$(sed -n 's/nis=//p' $active_appstatus)
                        echo -e "nis installed = $nis_installed"
                        sed -i "s/nis=$nis_current_value/nis=$nis_installed/g" $active_appstatus
                        nis=$(sed -n 's/nis=//p' $active_appstatus)
fi


#8 Check if Nextfare Central System (NCS) is installed
if [ -d "$bea_dir/ncs" ]
        then
                        ncs_installed="yes"
                        ncs_current_value=$(sed -n 's/ncs=//p' $active_appstatus)
                        echo -e "ncs installed = $ncs_installed"
                        sed -i "s/ncs=$ncs_current_value/ncs=$ncs_installed/g" $active_appstatus
                        ncs=$(sed -n 's/ncs=//p' $active_appstatus)
        else
                        ncs_installed="no"
                        ncs_current_value=$(sed -n 's/ncs=//p' $active_appstatus)
                        echo -e "ncs installed = $ncs_installed"
                        sed -i "s/ncs=$ncs_current_value/ncs=$ncs_installed/g" $active_appstatus
                        ncs=$(sed -n 's/ncs=//p' $active_appstatus)
fi


#9 Check if Order Management System (OMS) is installed
if [ -d "$cts_dir/oms" ]
        then
                        oms_installed="yes"
                        oms_current_value=$(sed -n 's/oms=//p' $active_appstatus)
                        echo -e "oms installed = $oms_installed"
                        sed -i "s/oms=$oms_current_value/oms=$oms_installed/g" $active_appstatus
                        oms=$(sed -n 's/oms=//p' $active_appstatus)
        else
                        oms_installed="no"
                        oms_current_value=$(sed -n 's/oms=//p' $active_appstatus)
                        echo -e "oms installed = $oms_installed"
                        sed -i "s/oms=$oms_current_value/oms=$oms_installed/g" $active_appstatus
                        oms=$(sed -n 's/oms=//p' $active_appstatus)
fi


#10 Check if Product Catalog (PRODCAT) is installed
if [ -d "$cts_dir/prodcat" ]
        then
                        prodcat_installed="yes"
                        prodcat_current_value=$(sed -n 's/prodcat=//p' $active_appstatus)
                        echo -e "prodcat installed = $prodcat_installed"
                        sed -i "s/prodcat=$prodcat_current_value/prodcat=$prodcat_installed/g" $active_appstatus
                        prodcat=$(sed -n 's/prodcat=//p' $active_appstatus)
        else
                        prodcat_installed="no"
                        prodcat_current_value=$(sed -n 's/prodcat=//p' $active_appstatus)
                        echo -e "prodcat installed = $prodcat_installed"
                        sed -i "s/prodcat=$prodcat_current_value/prodcat=$prodcat_installed/g" $active_appstatus
                        prodcat=$(sed -n 's/prodcat=//p' $active_appstatus)
fi

#11 Check if Payment Abstraction Layer (PAL) is installed
if [ -d "$cts_dir/pal" ]
        then
                        pal_installed="yes"
                        pal_current_value=$(sed -n 's/pal=//p' $active_appstatus)
                        echo -e "pal installed = $pal_installed"
                        sed -i "s/pal=$pal_current_value/pal=$pal_installed/g" $active_appstatus
                        pal=$(sed -n 's/pal=//p' $active_appstatus)
        else
                        pal_installed="no"
                        pal_current_value=$(sed -n 's/pal=//p' $active_appstatus)
                        echo -e "pal installed = $pal_installed"
                        sed -i "s/pal=$pal_current_value/pal=$pal_installed/g" $active_appstatus
                        pal=$(sed -n 's/pal=//p' $active_appstatus)
fi
;;

# Manually Configure

m)
#1 Verify if Application Monitor (APPMON) is installed
read -r -p "Is Application Monitor (APPMON) installed on this server [Y/N]:" appmon_installed
if [[ $appmon_installed =~ ^([yY][eE][sS]|[yY])$ ]]
       then
						appmon_installed="yes"
                        appmon_current_value=$(sed -n 's/appmon=//p' $active_appstatus)
                        echo -e "appmon installed = $appmon_installed"
                        sed -i "s/appmon=$appmon_current_value/appmon=$appmon_installed/g" $active_appstatus
                        appmon=$(sed -n 's/appmon=//p' $active_appstatus)
        else
                        appmon_installed="no"
                        appmon_current_value=$(sed -n 's/appmon=//p' $active_appstatus)
                        echo -e "appmon installed = $appmon_installed"
                        sed -i "s/appmon=$appmon_current_value/appmon=$appmon_installed/g" $active_appstatus
                        appmon=$(sed -n 's/appmon=//p' $active_appstatus)
fi



#2 Verify if Central Device Communication Server (CDCS) is installed
read -r -p "Is Central Device Communication Server (CDCS) installed on this server [Y/N]:" cdcs_installed
if [[ $cdcs_installed =~ ^([yY][eE][sS]|[yY])$ ]]
        then
						cdcs_installed="yes"
						cdcs_current_value=$(sed -n 's/cdcs=//p' $active_appstatus)
						echo -e "cdcs installed = $cdcs_installed"
						sed -i "s/cdcs=$cdcs_current_value/cdcs=$cdcs_installed/g" $active_appstatus
						cdcs=$(sed -n 's/cdcs=//p' $active_appstatus)
		else
						cdcs_installed="no"
                        cdcs_current_value=$(sed -n 's/cdcs=//p' $active_appstatus)
                        echo -e "cdcs installed = $cdcs_installed"
                        sed -i "s/cdcs=$cdcs_current_value/cdcs=$cdcs_installed/g" $active_appstatus
                        cdcs=$(sed -n 's/cdcs=//p' $active_appstatus)
fi


#3 Verify if Clearinghouse (CCH) is installed
read -r -p "Is Clearinghouse (CCH) installed on this server [Y/N]:" cch_installed
if [[ $cch_installed =~ ^([yY][eE][sS]|[yY])$ ]]
        then
                        cch_installed="yes"
                        cch_current_value=$(sed -n 's/cch=//p' $active_appstatus)
                        echo -e "cch installed = $cch_installed"
                        sed -i "s/cch=$cch_current_value/cch=$cch_installed/g" $active_appstatus
                        cch=$(sed -n 's/cch=//p' $active_appstatus)
        else
                        cch_installed="no"
                        cch_current_value=$(sed -n 's/cch=//p' $active_appstatus)
                        echo -e "cch installed = $cch_installed"
                        sed -i "s/cch=$cch_current_value/cch=$cch_installed/g" $active_appstatus
                        cch=$(sed -n 's/cch=//p' $active_appstatus)
fi


#4 Verify if Cubic Notification Gateway (CNG) is installed
read -r -p "Is Cubic Notification Gateway (CNG) installed on this server [Y/N]:" cng_installed
if [[ $cng_installed =~ ^([yY][eE][sS]|[yY])$ ]]
        then
                        cng_installed="yes"
                        cng_current_value=$(sed -n 's/cng=//p' $active_appstatus)
                        echo -e "cng installed = $cng_installed"
                        sed -i "s/cng=$cng_current_value/cng=$cng_installed/g" $active_appstatus
                        cng=$(sed -n 's/cng=//p' $active_appstatus)
        else
                        cng_installed="no"
                        cng_current_value=$(sed -n 's/cng=//p' $active_appstatus)
                        echo -e "cng installed = $cng_installed"
                        sed -i "s/cng=$cng_current_value/cng=$cng_installed/g" $active_appstatus
                        cng=$(sed -n 's/cng=//p' $active_appstatus)
fi


#5 Verify if Cubic Payment Application (CPA) is installed
read -r -p "Is Cubic Payment Application (CPA) installed on this server [Y/N]:" cpa_installed
if [[ $cpa_installed =~ ^([yY][eE][sS]|[yY])$ ]]
        then
                        cpa_installed="yes"
                        cpa_current_value=$(sed -n 's/cpa=//p' $active_appstatus)
                        echo -e "cpa installed = $cpa_installed"
                        sed -i "s/cpa=$cpa_current_value/cpa=$cpa_installed/g" $active_appstatus
                        cpa=$(sed -n 's/cpa=//p' $active_appstatus)
        else
                        cpa_installed="no"
                        cpa_current_value=$(sed -n 's/cpa=//p' $active_appstatus)
                        echo -e "cpa installed = $cpa_installed"
                        sed -i "s/cpa=$cpa_current_value/cpa=$cpa_installed/g" $active_appstatus
                        cpa=$(sed -n 's/cpa=//p' $active_appstatus)
fi


#6 Verify if Event Collector (EC) is installed
read -r -p "Is Event Collector (EC) installed on this server [Y/N]:" ec_installed
if [[ $ec_installed =~ ^([yY][eE][sS]|[yY])$ ]]
        then
                        ec_installed="yes"
                        ec_current_value=$(sed -n 's/ec=//p' $active_appstatus)
                        echo -e "ec installed = $ec_installed"
                        sed -i "s/ec=$ec_current_value/ec=$ec_installed/g" $active_appstatus
                        ec=$(sed -n 's/ec=//p' $active_appstatus)
        else
                        ec_installed="no"
                        ec_current_value=$(sed -n 's/ec=//p' $active_appstatus)
                        echo -e "ec installed = $ec_installed"
                        sed -i "s/ec=$ec_current_value/ec=$ec_installed/g" $active_appstatus
                        ec=$(sed -n 's/ec=//p' $active_appstatus)
fi


#7 Verify if Nextfare Integration System (NIS) is installed
read -r -p "Is Nextfare Integration System (NIS) installed on this server [Y/N]:" nis_installed
if [[ $nis_installed =~ ^([yY][eE][sS]|[yY])$ ]]
        then
                        nis_installed="yes"
                        nis_current_value=$(sed -n 's/nis=//p' $active_appstatus)
                        echo -e "nis installed = $nis_installed"
                        sed -i "s/nis=$nis_current_value/nis=$nis_installed/g" $active_appstatus
                        nis=$(sed -n 's/nis=//p' $active_appstatus)
        else
                        nis_installed="no"
                        nis_current_value=$(sed -n 's/nis=//p' $active_appstatus)
                        echo -e "nis installed = $nis_installed"
                        sed -i "s/nis=$nis_current_value/nis=$nis_installed/g" $active_appstatus
                        nis=$(sed -n 's/nis=//p' $active_appstatus)
fi


#8 Verify if Nextfare Central System (NCS) is installed
read -r -p "Is Nextfare Central System (NCS) installed on this server [Y/N]:" ncs_installed
if [[ $ncs_installed =~ ^([yY][eE][sS]|[yY])$ ]]
        then
                        ncs_installed="yes"
                        ncs_current_value=$(sed -n 's/ncs=//p' $active_appstatus)
                        echo -e "ncs installed = $ncs_installed"
                        sed -i "s/ncs=$ncs_current_value/ncs=$ncs_installed/g" $active_appstatus
                        ncs=$(sed -n 's/ncs=//p' $active_appstatus)
        else
                        ncs_installed="no"
                        ncs_current_value=$(sed -n 's/ncs=//p' $active_appstatus)
                        echo -e "ncs installed = $ncs_installed"
                        sed -i "s/ncs=$ncs_current_value/ncs=$ncs_installed/g" $active_appstatus
                        ncs=$(sed -n 's/ncs=//p' $active_appstatus)
fi


#9 Verify if Order Management System (OMS) is installed
read -r -p "Is Order Management System (OMS) installed on this server [Y/N]:" oms_installed
if [[ $oms_installed =~ ^([yY][eE][sS]|[yY])$ ]]
        then
                        oms_installed="yes"
                        oms_current_value=$(sed -n 's/oms=//p' $active_appstatus)
                        echo -e "oms installed = $oms_installed"
                        sed -i "s/oms=$oms_current_value/oms=$oms_installed/g" $active_appstatus
                        oms=$(sed -n 's/oms=//p' $active_appstatus)
        else
                        oms_installed="no"
                        oms_current_value=$(sed -n 's/oms=//p' $active_appstatus)
                        echo -e "oms installed = $oms_installed"
                        sed -i "s/oms=$oms_current_value/oms=$oms_installed/g" $active_appstatus
                        oms=$(sed -n 's/oms=//p' $active_appstatus)
fi



#10 Verify if Product Catalog (PRODCAT) is installed
read -r -p "Is Product Catalog (PRODCAT) installed on this server [Y/N]:" prodcat_installed
if [[ $prodcat_installed =~ ^([yY][eE][sS]|[yY])$ ]]
        then
                        prodcat_installed="yes"
                        prodcat_current_value=$(sed -n 's/prodcat=//p' $active_appstatus)
                        echo -e "prodcat installed = $prodcat_installed"
                        sed -i "s/prodcat=$prodcat_current_value/prodcat=$prodcat_installed/g" $active_appstatus
                        prodcat=$(sed -n 's/prodcat=//p' $active_appstatus)
        else
                        prodcat_installed="no"
                        prodcat_current_value=$(sed -n 's/prodcat=//p' $active_appstatus)
                        echo -e "prodcat installed = $prodcat_installed"
                        sed -i "s/prodcat=$prodcat_current_value/prodcat=$prodcat_installed/g" $active_appstatus
                        prodcat=$(sed -n 's/prodcat=//p' $active_appstatus)
fi


#11 Verify if Payment Abstraction Layer (PAL) is installed
read -r -p "Is Payment Abstraction Layer (PAL) installed on this server [Y/N]:" pal_installed
if [[ $pal_installed =~ ^([yY][eE][sS]|[yY])$ ]]
        then
                        pal_installed="yes"
                        pal_current_value=$(sed -n 's/pal=//p' $active_appstatus)
                        echo -e "pal installed = $pal_installed"
                        sed -i "s/pal=$pal_current_value/pal=$pal_installed/g" $active_appstatus
                        pal=$(sed -n 's/pal=//p' $active_appstatus)
        else
                        pal_installed="no"
                        pal_current_value=$(sed -n 's/pal=//p' $active_appstatus)
                        echo -e "pal installed = $pal_installed"
                        sed -i "s/pal=$pal_current_value/pal=$pal_installed/g" $active_appstatus
                        pal=$(sed -n 's/pal=//p' $active_appstatus)
fi

;;
esac



## Deploy configuration ##


# Deploy the updated Appstatus.sh script
active_appstatus=/opt/cubic_appmenu/templates/active_appstatus_config.sh
live_appstatus=/opt/cubic_appmenu/scripts/appstatus_config.sh
cat $active_appstatus > $live_appstatus



## Auto populate files ##

# Create appmenu.lst from template
default_appmenu=/opt/cubic_appmenu/templates/default_appmenu.lst
active_appmenu=/opt/cubic_appmenu/templates/active_appmenu.lst
cat $default_appmenu > $active_appmenu

# Create logmenu.lst from template
default_logmenu=/opt/cubic_appmenu/templates/default_logmenu.lst
active_logmenu=/opt/cubic_appmenu/templates/active_logmenu.lst
cat $default_logmenu > $active_logmenu

# Create appmenu_profile.sh from template
default_profile=/opt/cubic_appmenu/templates/default_profile.sh
active_profile=/opt/cubic_appmenu/templates/active_profile.sh
cat $default_profile > $active_profile

# Update Environment name in configuration files
sed -i "s/Environment_Name/$env_upper/g" $active_appmenu
sed -i "s/Environment_Name/$env_upper/g" $active_logmenu


#1 Delete Application Monitor (APPMON) from menu list if not installed
if [ $appmon_installed = no ]
        then
        sed -i '/APPMON/,+1d' $active_appmenu
        sed -i '/APPMON/,+1d' $active_logmenu
	sed -i '/APPMON/,+1d' $active_profile
fi

#2 Delete Central Device Communication Server (CDCS) from menu list if not installed
if [ $cdcs_installed = no ]
	then
	sed -i '/CDCS/,+1d' $active_appmenu
	sed -i '/CDCS/,+1d' $active_logmenu
        sed -i '/CDCS/,+1d' $active_profile
fi

#3 Delete Clearinghouse (CCH) from menu list if not installed
if [ $cch_installed = no ]
        then
        sed -i '/CCH/,+1d' $active_appmenu
	sed -i '/CCH/,+1d' $active_logmenu
        sed -i '/CCH/,+1d' $active_profile
fi

#4 Delete Cubic Notification Gateway (CNG) from menu list if not installed
if [ $cng_installed = no ]
        then
        sed -i '/CNG/,+1d' $active_appmenu
	sed -i '/CNG/,+1d' $active_logmenu
	sed -i '/CNG/,+1d' $active_profile
fi

#5 Delete Cubic Payment Application (CPA) from menu list if not installed
if [ $cpa_installed = no ]
        then
        sed -i '/CPA/,+1d' $active_appmenu
        sed -i '/CPA/,+1d' $active_logmenu
	sed -i '/CPA/,+1d' $active_profile
fi

#6 Delete Event Collector (EC) from menu list if not installed
if [ $ec_installed = no ]
        then
        sed -i '/EC/,+1d' $active_appmenu
	sed -i '/EC/,+1d' $active_logmenu
	sed -i '/EC/,+1d' $active_profile
fi

#7 Delete Nextfare Integration System (NIS) from menu list if not installed
if [ $nis_installed = no ]
        then
        sed -i '/NIS/,+1d' $active_appmenu
	sed -i '/NIS/,+1d' $active_logmenu
	sed -i '/NIS/,+1d' $active_profile
fi

#8 Delete Nextfare Central System (NCS) from menu list if not installed
if [ $ncs_installed = no ]
        then
        sed -i '/NCS/,+1d' $active_appmenu
        sed -i '/NCS/,+1d' $active_logmenu
	sed -i '/NCS/,+1d' $active_profile
fi

#8b Delete Nextfare Central System (NCS) from menu list if not installed
if [ $ncs_installed = yes ]
        then
        sed -i '/TM/,+1d' $active_appmenu
fi

#8c Delete Nextfare Central System (NCS) Admin Console from menu list if not installed
if [ $ncs_installed = yes ] 
        then
        hostname=$(hostname)
	hostname_lower=$(echo $hostname | awk '{print tolower($0)}' | awk -F. '{print $1}')
	admin_hostname=$(sed -n 's/WLS_ADMIN_ADDRESS=//p' $bea_dir/ncs/install-unix.properties | tr -d '\r\n')
	ip_add=$(hostname --ip-address)
		if [ $hostname_lower = $admin_hostname ] || [ $ip_add = $admin_hostname ]
        		then
                		echo "The NCS Admin console is installed on $hostname_lower and will be added to CTS appmenu"
				admc_installed="yes"
				admc_current_value=$(sed -n 's/admc=//p' $active_appstatus)
				sed -i "s/admc=$admc_current_value/admc=$admc_installed/g" $active_appstatus
        		else
                		echo "The NCS Admin console is NOT installed on $hostname_lower and will be excluded from the CTS appmenu"
				sed -i '/ADMC/,+1d' $active_appmenu
				admc_installed="no"
				admc_current_value=$(sed -n 's/admc=//p' $active_appstatus)
				sed -i "s/admc=$admc_current_value/admc=$admc_installed/g" $active_appstatus
		fi	
fi


#9 Delete Order Management System (OMS) from menu list if not installed
if [ $oms_installed = no ]
        then
        sed -i '/OMS/,+1d' $active_appmenu
	sed -i '/OMS/,+1d' $active_logmenu
	sed -i '/OMS/,+1d' $active_profile
fi

#10 Delete Product Catalog (PRODCAT) from menu list if not installed
if [ $prodcat_installed = no ]
        then
        sed -i '/PRODCAT/,+1d' $active_appmenu
	sed -i '/PRODCAT/,+1d' $active_logmenu
	sed -i '/PRODCAT/,+1d' $active_profile
fi

#11 Delete Payment Abstraction Layer (PAL) from menu list if not installed
if [ $pal_installed = no ]
        then
        sed -i '/PAL/,+1d' $active_appmenu
	sed -i '/PAL/,+1d' $active_logmenu
	sed -i '/PAL/,+1d' $active_profile
fi



## Deploy updated configurations ###

# Deploy the updated Appstatus.sh script
active_appstatus=/opt/cubic_appmenu/templates/active_appstatus_config.sh
live_appstatus=/opt/cubic_appmenu/scripts/appstatus_config.sh
cat $active_appstatus > $live_appstatus

# Deploy updated appmenu.lst
active_appmenu=/opt/cubic_appmenu/templates/active_appmenu.lst
live_appmenu=/opt/cubic_appmenu/menu_config/appmenu.lst
cat $active_appmenu > $live_appmenu

# Deploy updated logmenu.lst
active_logmenu=/opt/cubic_appmenu/templates/active_logmenu.lst
live_logmenu=/opt/cubic_appmenu/menu_config/logmenu.lst
cat $active_logmenu > $live_logmenu

# Deploy updated profile
active_profile=/opt/cubic_appmenu/templates/active_profile.sh
live_profile=/etc/profile.d/appmenu_profile.sh
cat $active_profile > $live_profile


echo -e "${yellow}The CTS Appmenu has been installed!${NC}"
echo -e "\nTo run the appmenu in this session please run the following source command below:"
echo -e "source /opt/cubic_appmenu/templates/active_profile.sh"
echo -e "\nNow you can launch the CTS Appmenu with the following command in all future sessions: appmenu"
