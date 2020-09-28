#!/bin/bash

EVA_FILE_LIST=($(find /etc/fdfs -type f -name "*.tpl"))
for EVA_FILE in "${EVA_FILE_LIST[@]}"; do
  YML_FILE_NAME=$(echo ${EVA_FILE} | sed 's/.tpl//g')
  envsubst <${EVA_FILE} >${YML_FILE_NAME}
done

if [ "$RUNNING_MODE" = "storage" ]; then
    cat /etc/fdfs/storage.conf
    /etc/init.d/fdfs_storaged start
elif [ "$RUNNING_MODE" = "tracker" ]; then
    cat /etc/fdfs/tracker.conf
    /etc/init.d/fdfs_trackerd start
elif [ "$RUNNING_MODE" = "nginx" ]; then
    ./usr/local/nginx/sbin/nginx
