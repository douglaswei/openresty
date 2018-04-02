#!/bin/bash

LOGS_PATH=/data/logs/nginx
LAST_HOUR=$(date -d "-1 hours" +%Y-%m-%d-%H)

function mk_path_if_not_exist ()
{
    if [ ! -d "$1" ]; then
        mkdir -p $1
    fi
}

mk_path_if_not_exist ${LOGS_PATH}/access
mk_path_if_not_exist ${LOGS_PATH}/error
mk_path_if_not_exist ${LOGS_PATH}/post


mv ${LOGS_PATH}/access.log ${LOGS_PATH}/access/${LAST_HOUR}.log
mv ${LOGS_PATH}/error.log ${LOGS_PATH}/error/${LAST_HOUR}.log
mv ${LOGS_PATH}/post.log ${LOGS_PATH}/post/${LAST_HOUR}.log

# reopen log
kill -USR1 $(cat /data/webapps/nginx/nginx.pid)

# 删除5天之前的日志
find /data/logs/* -type f -mtime +5 -exec rm {} \;
