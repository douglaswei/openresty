#!/bin/sh

sed -i 's/KAFKA_HOST/\"'${KAFKA_HOST}'\"/' /data/webapps/nginx/conf/lua/kafka_push.lua
sed -i 's/KAFKA_PORT/'${KAFKA_PORT}'/' /data/webapps/nginx/conf/lua/kafka_push.lua

/usr/local/openresty/bin/openresty -g "daemon off;" -c /data/webapps/nginx/conf/nginx.conf

