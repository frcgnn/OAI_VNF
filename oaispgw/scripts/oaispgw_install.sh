#!/bin/bash

if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file 

echo "127.0.1.1       $hostname.3gppnetwork.org $hostname" >> /etc/hosts

create_interface_config_file "ens4" >> $LOGFILE 2>&1

mkdir $LOG_DIR
source_generic_service_file "oaispgw" "install" "ens4" "ens3" "$net_d_oa" >> $LOGFILE 2>&1
update_config_file "SGW_INTERFACE_NAME_FOR_S11              = \"lo\"; " "SGW_INTERFACE_NAME_FOR_S11              = \"ens4\"; " $ETC_TARGET/spgw.conf   >> $LOGFILE 2>&1
update_config_file "SGW_IPV4_ADDRESS_FOR_S11                = \"127.0.11.2\/8\";" "SGW_IPV4_ADDRESS_FOR_S11                = \"$net_d_oa\/8\";" $ETC_TARGET/spgw.conf   >> $LOGFILE 2>&1


echo "finished install script"
echo "finished install script" >> $LOGFILE 2>&1


