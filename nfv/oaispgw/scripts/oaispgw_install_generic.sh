#!/bin/bash

if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file

SIGNAL_INTERFACE=$1
WEB_INTERFACE=$2
SIGNAL_IP=$3

cp $OPENAIRCN_ETC/spgw.conf $ETC_TARGET

update_config_file "SGW_INTERFACE_NAME_FOR_S1U_S12_S4_UP    = \"eth0\";" "SGW_INTERFACE_NAME_FOR_S1U_S12_S4_UP    = \"$SIGNAL_INTERFACE\";" $ETC_TARGET/spgw.conf 
update_config_file "SGW_IPV4_ADDRESS_FOR_S1U_S12_S4_UP      = \"192.168.11.17\/24\";" "SGW_IPV4_ADDRESS_FOR_S1U_S12_S4_UP      = \"$SIGNAL_IP\/24\";" $ETC_TARGET/spgw.conf 
update_config_file "PGW_INTERFACE_NAME_FOR_SGI            = \"eth3\";" "PGW_INTERFACE_NAME_FOR_SGI            = \"$WEB_INTERFACE\";" $ETC_TARGET/spgw.conf
update_config_file "DEFAULT_DNS_IPV4_ADDRESS     = \"8.8.8.8\"" "DEFAULT_DNS_IPV4_ADDRESS     = \"$DNS\"" $ETC_TARGET/spgw.conf
update_config_file "172.16.0.0\/12" "172.16.0.0\/24" $ETC_TARGET/spgw.conf
update_config_file "PGW_MASQUERADE_SGI                    = \"no\";" "PGW_MASQUERADE_SGI                    = \"yes\";" $ETC_TARGET/spgw.conf

install_service_file "spgw"

