#!/bin/bash
#
# Created: 	19 Jun 2018 
# Last Up: 	 8 Jul 2019 
# 
# Creates a Vacuumed Backup of the Prod Database
# Gzips and Sends it to Remote (Docean)
#

logfile="/home/gibil/jx_data/pg.log"
dir="/home/gibil/jx_data/local/"
database="Odoo9-min"
dateinfo=`date '+%Y-%m-%d %H:%M:%S'`
timeslot=`date '+%Y_%m_%d_%H_%M'`

touch $logfile

echo "Starting backup" >> $logfile
echo $database >> $logfile
echo $timeslot >> $logfile

/usr/bin/vacuumdb $database
/usr/bin/pg_dump $database > $dir$timeslot.backup

/bin/gzip $dir$timeslot.backup

echo "Done backup of database" >> $logfile
echo "" >> $logfile

tail -15 $logfile | mailx jrevilla55@gmail.com

