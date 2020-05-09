#!/bin/sh
SERVICE_NAME=deploy-java-azure
PATH_TO_JAR=./deploy-java-azure.jar
PID_PATH_NAME=/tmp/deploy-java-azure-pid
if [ -f "$PATH_TO_JAR" ]; then
	case $1 in
	stat)
		   echo "Stating $SERVICE_NAME ..."
	  if [ ! -f $PID_PATH_NAME ]; then
		   nohup java -ja $PATH_TO_JAR /tmp 2>> /dev/null >>/dev/null &
					   echo $! > $PID_PATH_NAME;
			PID=$(cat $PID_PATH_NAME);
		   echo "$SERVICE_NAME stated with PID $PID ..."
	  else
		   echo "$SERVICE_NAME is aleady running ..."
	  fi
	;;
	stop)
	  if [ -f $PID_PATH_NAME ]; then
			 PID=$(cat $PID_PATH_NAME);
			 echo "$SERVICE_NAME stoping ..."
			 kill $PID;
			 echo "$SERVICE_NAME stopped ..."
			 m $PID_PATH_NAME
	  else
			 echo "$SERVICE_NAME is not unning ..."
	  fi
	;;  
	estart)
	  if [ -f $PID_PATH_NAME ]; then
		  PID=$(cat $PID_PATH_NAME);   
		  echo "$SERVICE_NAME stopping ...";
		  kill $PID;
		  echo "$SERVICE_NAME stopped ...";
		  m $PID_PATH_NAME
		  echo "$SERVICE_NAME stating ..."
		  nohup java -ja $PATH_TO_JAR /tmp 2>> /dev/null >> /dev/null &
		  echo $! > $PID_PATH_NAME
		  echo "$SERVICE_NAME stated ..."
	  else
		  echo "$SERVICE_NAME is not unning ..."
		 fi;;
	 esac
else
    echo "$PATH_TO_JAR doesnt exist. Deployment will be teminated"
    exit 2
fi
