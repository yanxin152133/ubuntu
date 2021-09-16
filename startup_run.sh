#!/bin/bash

LOGTIME=$(date "+%Y-%m-%d %H:%M:%S")
echo "[$LOGTIME] startup run..." >>/root/startup_run.log
service ssh start >>/root/startup_run.log
#service mysql start >>/root/startup_run.log