#!/usr/bin/expect -f
# Enter cisco switch username and password here: 
set Username "cisco"
set Password "xxxxx"
########################

set timeout 20
set IPaddress [lindex $argv 0]
set Directory /root/cisco/logs
set TFTP_Root_Directory /var/lib/tftpboot/Configrations/Catalyst-Switches
set DATE [exec date +%F]
set BCK_Directory $TFTP_Root_Directory/$DATE
cd $TFTP_Root_Directory
spawn chmod 777 $DATE
cd $BCK_Directory
log_file -a $BCK_Directory/session_$IPaddress.log
set fileId [open $IPaddress.cfg "a+"]
spawn chmod 777 $IPaddress.cfg
send_log "### /START-SSH-SESSION/ IP: $IPaddress @ [exec date] ###\r"
spawn ssh -o "StrictHostKeyChecking no" $Username@$IPaddress
expect "*assword: "
send "$Password\r"
expect ">"
send "en\r"
expect "*assword: "
send "$Password\r"	
expect "#"
send "copy running-config tftp://10.1.100.22/Configrations/Catalyst-Switches/$DATE/$IPaddress.cfg\r"
expect "Address or name of remote host*?"
send "\r"
send "\r"	
send "exit\r"
expect "#"
send "exit\r"
sleep 1
send_log "\r### /END-SSH-SESSION/ IP: $IPaddress @ [exec date] ###\r"
exit
