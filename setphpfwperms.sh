#!/bin/sh

#MIT License

#Copyright (c) 2016 Salva Camarasa

#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

# This script is meant to lessen the pain after a new PHP project is created,
# as it automatically gives the needed permissions to www-data (or whatever
# the HTTPD user is), for some of the most popular PHP frameworks.

#Vars
FILE="/tmp/out.$$"
GREP="/bin/grep"
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

#Functions
usage()
{
	#Shows instructions of usage
	echo "Usage: sh setfwpermissions.sh [framework/app]"
	echo "Example: sh setfwpermissions.sh laravel5"
	echo "Available frameworks: "
	echo "laravel5"
	echo "f3"	
	echo "cake3"
	echo "wordpress"
	echo "prestashop"
}

version()
{
	#Show Version
	echo "v 1.0.1"
}

set_acl_laravel5()
{
	echo "Setting up permisions for ${GREEN}Laravel 5${RESET}..."
	if [ -d storage -a -d bootstrap/cache ]; then 	
		setfacl -R -m u:${HTTPDUSER}:rwx storage
		setfacl -R -d -m u:${HTTPDUSER}:rwx storage
		setfacl -R -m u:${HTTPDUSER}:rwx bootstrap/cache
		setfacl -R -d -m u:${HTTPDUSER}:rwx bootstrap/cache
		echo "${GREEN}SUCCESS:${RESET} Permissions set."
		exit 0	
	else
		echo "${RED}ERROR:${RESET} No specific folders of the framework found! Exiting..." 1>&2
		exit 1
	fi	
}

set_acl_f3()
{
	echo "Setting up permisions for ${GREEN}Fat Free Framework${RESET}..."
	if [ -d tmp ]; then
		setfacl -R -m u:${HTTPDUSER}:rwx tmp
		setfacl -R -d -m u:${HTTPDUSER}:rwx tmp
		echo "${GREEN}SUCCESS:${RESET} Permissions set."
		exit 0
	else
		if [ -d lib -a -d ui ]; then
			mkdir 'tmp'
			setfacl -R -m u:${HTTPDUSER}:rwx tmp
			setfacl -R -d -m u:${HTTPDUSER}:rwx tmp
			echo "${GREEN}SUCCESS:${RESET} Permissions set."
			exit 0
		else
			echo "${RED}ERROR:${RESET} No specific folders of the framework found! Exiting..." 1>&2
			exit 1
		fi
	fi
}

set_acl_cake3()
{
	echo "Setting up permisions for ${GREEN}CakePHP 3${RESET}..."
	if [ -d tmp -a -d logs ]; then
		setfacl -R -m u:${HTTPDUSER}:rwx tmp
		setfacl -R -d -m u:${HTTPDUSER}:rwx tmp
		setfacl -R -m u:${HTTPDUSER}:rwx logs
		setfacl -R -d -m u:${HTTPDUSER}:rwx logs
		echo "${GREEN}SUCCESS:${RESET} Permissions set."
		exit 0
	else
		echo "${RED}ERROR:${RESET} No specific folders of the framework found! Exiting..." 1>&2
		exit 1
	fi
}

set_acl_wp()
{
	echo "Setting up permisions for ${GREEN}Wordpress${RESET}..."
	if [ -d wp-content ]; then
		setfacl -R -m u:${HTTPDUSER}:rwx wp-content
		setfacl -R -d -m u:${HTTPDUSER}:rwx wp-content
		echo "${GREEN}SUCCESS:${RESET} Permissions set."
		exit 0
	else
		echo "${RED}ERROR:${RESET} No specific folders of the framework found! Exiting..." 1>&2
		exit 1
	fi
}

set_acl_prestashop()
{
	echo "Setting up permisions for ${GREEN}Prestashop${RESET}..."
	if [ -d config -a -d cache -a -d log -a -d img -a -d mails ] && \
		[ -d modules -a -d themes/default-bootstrap/lang ] && \
		[ -d themes/default-bootstrap/pdf/lang -a -d themes/default-bootstrap/cache ] && \
		[ -d translations -a -d upload -a -d download ]; then

		setfacl -R -m u:${HTTPDUSER}:rwx config
		setfacl -R -d -m u:${HTTPDUSER}:rwx config
		setfacl -R -m u:${HTTPDUSER}:rwx cache
		setfacl -R -d -m u:${HTTPDUSER}:rwx cache
		setfacl -R -m u:${HTTPDUSER}:rwx log
		setfacl -R -d -m u:${HTTPDUSER}:rwx log
		setfacl -R -m u:${HTTPDUSER}:rwx img
		setfacl -R -d -m u:${HTTPDUSER}:rwx img
		setfacl -R -m u:${HTTPDUSER}:rwx mails
		setfacl -R -d -m u:${HTTPDUSER}:rwx mails
		setfacl -R -m u:${HTTPDUSER}:rwx modules
		setfacl -R -d -m u:${HTTPDUSER}:rwx modules
		setfacl -R -m u:${HTTPDUSER}:rwx themes/default-bootstrap/lang
		setfacl -R -d -m u:${HTTPDUSER}:rwx themes/default-bootstrap/lang
		setfacl -R -m u:${HTTPDUSER}:rwx themes/default-bootstrap/pdf/lang
		setfacl -R -d -m u:${HTTPDUSER}:rwx themes/default-bootstrap/pdf/lang
		setfacl -R -m u:${HTTPDUSER}:rwx themes/default-bootstrap/cache
		setfacl -R -d -m u:${HTTPDUSER}:rwx themes/default-bootstrap/cache
		setfacl -R -m u:${HTTPDUSER}:rwx translations
		setfacl -R -d -m u:${HTTPDUSER}:rwx translations
		setfacl -R -m u:${HTTPDUSER}:rwx upload
		setfacl -R -d -m u:${HTTPDUSER}:rwx upload
		setfacl -R -m u:${HTTPDUSER}:rwx download
		setfacl -R -d -m u:${HTTPDUSER}:rwx download
		
		echo "${GREEN}SUCCESS:${RESET} Permissions set."
		exit 0
	else
		echo "${RED}ERROR:${RESET} No specific folders of the framework found! Exiting..."
		exit 1
	fi
}

# Make sure only root can run our script
if [ "$(id -u)" != 0 ]; then
   	echo "Rats! This script must be run as root" 1>&2
   	exit 1

else 
	#Get current HTTPD user 
	HTTPDUSER=`ps aux | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1`	
	echo "HTTPDUSER is ${GREEN}$HTTPDUSER${RESET}"

	#Check arguments
	if [ -z "$1" ]; then
		echo "${RED}ERROR:${RESET} Bad Usage: You must specifiy the PHP framework/app to set permissions to!" 1>&2
		usage
		exit 1

	else
		while [ "$1" != "" ]; do
			case $1 in
				-h | --help )		shift
									usage
									exit 0					
									;;
				-v | --version )	version
									exit 0
									;;
				'laravel5' )		set_acl_laravel5
									;;
				'f3' )				set_acl_f3
									;;
				'cake3' )			set_acl_cake3
									;;
				'wordpress' )		set_acl_wp
									;;
				'prestashop' )		set_acl_prestashop
									;;
				* )					echo "${RED}ERROR:${RESET} Invalid argument!"
									usage
									exit 0
			esac
			shift
		done
	fi
fi
