#!/bin/sh

# start Xvfb
/usr/bin/Xvfb :99 -ac -screen 0 1024x768x24 &
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
  echo "Registering host $APP_HOST"
  echo "$HOST_IP $APP_HOST" >> /etc/hosts
fi;

# if onlu port provided - redirect to host+port
if [ $APP_PORT ];
then
  echo "Registering port $APP_PORT"
  socat TCP4-LISTEN:$APP_PORT,fork,reuseaddr TCP4:dockerhost:$APP_PORT &
fi;

# starting selenium
java -jar selenium-server.jar
