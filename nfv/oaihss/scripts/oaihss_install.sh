#!/bin/bash

if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file

if [ ! -d $OPENAIRCN_DIR ]; then
  echo "downloading and installing oai software" >> $LOGFILE 2>&1
  download_and_build_oai  >> $LOGFILE 2>&1
else
  echo "using pre-installed image" >> $LOGFILE 2>&1
fi

echo "127.0.1.1       hss.openair4G.eur   hss" >> /etc/hosts
echo "127.0.1.1       $hostname" >> /etc/hosts

#SIGNAL_INTERFACE=$(getInterfaceName 2)

#create_interface_config_file "$SIGNAL_INTERFACE" >> $LOGFILE 2>&1

source_generic_service_file "oaihss" "install" >> $LOGFILE 2>&1

echo "finished install script"
echo "finished install script" >> $LOGFILE 2>&1


