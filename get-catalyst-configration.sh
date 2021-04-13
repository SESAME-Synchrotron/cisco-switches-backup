#!/bin/bash
old_folder_name=$(date "+%F")
mkdir /var/lib/tftpboot/Configrations/Catalyst-Switches/$old_folder_name
while read  ipadd

do

#echo $ipadd

export ipadd

./get-configration.sh $ipadd

done < IP-list

new_folder_time=$(date "+%Y.%m.%d-%H.%M.%S")

mv /var/lib/tftpboot/Configrations/$old_folder_name /var/lib/tftpboot/Configrations/Catalyst-Switches/$new_folder_time
