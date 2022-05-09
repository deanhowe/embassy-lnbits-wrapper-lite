#!/bin/bash

set -ea

if [ "$1" = "" ]; then
  echo "We need to know what LNBts instance to start?" >> /var/log/lnbits.log
  exit 1
fi

INSTANCE_NAME='Instance I'  

if [ "$1" = "1" ]; then
  INSTANCE_NAME='Instance II'
elif [ "$1" = "2" ]; then
  INSTANCE_NAME='Instance III'
elif [ "$1" = "3" ]; then
  INSTANCE_NAME='Instance IV'
elif [ "$1" = "4" ]; then
  INSTANCE_NAME='Instance V'
elif [ "$1" = "5" ]; then
  INSTANCE_NAME='Instance VI'
fi


if [ ! -d /home/lnbits/app/500$1 ]; then

  echo "Trying to start $INSTANCE_NAME - but don't have any configs for that instance?" >> /var/log/lnbits.log
  exit 1

fi

if [ ! -d /home/lnbits/app/500$1/lnbits ]; then

  cp -pr /lnbits/lnbits /home/lnbits/app/500$1/lnbits
  echo "New LNbits instance created [$INSTANCE_NAME] ( we copied some files... )" >> /var/log/lnbits.log
  
  mkdir -p /datadir/lnbits/5000/data
  
  echo "We also created some directories to store the SQLite database files for $INSTANCE_NAME " >> /var/log/lnbits.log

fi

# Enable auto-reload.
# --reload 

# Log level. [default: info]
# --log-level [critical|error|warning|info|debug|trace]

#  --access-log / --no-access-log  Enable/Disable access log.
#  --use-colors / --no-use-colors  Enable/Disable colorized logging.

screen -dmS 500$1 bash -c "cd /home/lnbits/app/500$1; /lnbits/venv/bin/uvicorn lnbits.__main__:app --port 500$1 --host 0.0.0.0 &> /var/log/lnbits.log "

action_result="    {
    \"version\": \"0\",
    \"message\": \"Please check the **logs** for more details. \\n But it all looks good sa far 🚀 🌕\",
    \"value\": null,
    \"copyable\": false,
    \"qr\": false
}"

echo $action_result
