#!/bin/bash

# start Xvfb
if [ ! $RESOLUTION ];
then
  RESOLUTION="1024x768x24"
fi;

echo "Running Xvfb at $RESOLUTION"

/usr/bin/Xvfb :99 -ac -screen 0 $RESOLUTION &
export DISPLAY=:99.0

# get host ip
export HOST_IP=$(/sbin/ip route|awk '/default/ { print $3 }')

echo "Running Selenium Env: Selenium Server, and Xvfb with Firefox and Chromium"
echo "Host IP: $HOST_IP"

# adding IP of a host to /etc/hosts
echo "$HOST_IP dockerhost" >> /etc/hosts

# adding APP_HOST to list of known hosts
if [ $APP_HOST ];
then
  HOSTS=(${APP_HOST//,/ });

  for i in "${!HOSTS[@]}"
  do
    echo "Registering host ${HOSTS[i]}"
    echo "$HOST_IP ${HOSTS[i]}" >> /etc/hosts
  done;
fi;

# if only port provided - redirect to host+port
if [ $APP_PORT ];
then
  PORTS=(${APP_PORT//,/ });

  for i in "${!PORTS[@]}"
  do
    echo "Registering port ${PORTS[i]}"
    socat TCP4-LISTEN:${PORTS[i]},fork,reuseaddr TCP4:dockerhost:${PORTS[i]} &
  done;
fi;

# starting selenium
java -jar selenium-server.jar
