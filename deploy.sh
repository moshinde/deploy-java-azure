#!/bin/sh
SERVICE_NAME=deploy-java-azure
PATH_TO_JAR=./deploy-java-azure.jar
PID_PATH_NAME=/tmp/deploy-java-azure-pid
if [ -f "$PATH_TO_JAR" ]; then
    echo "$PATH_TO_JAR exist .."
	case $1 in
	start)
		   echo "Starting $SERVICE_NAME ..."
	  if [ ! -f $PID_PATH_NAME ]; then
		   nohup java -jar $PATH_TO_JAR /tmp 2>> /dev/null >>/dev/null &
					   echo $! > $PID_PATH_NAME;
			PID=$(cat $PID_PATH_NAME);
		   echo "$SERVICE_NAME started with PID $PID ..."
	  else
		   echo "$SERVICE_NAME is already running ..."
	  fi
	;;
	stop)
	  if [ -f $PID_PATH_NAME ]; then
			 PID=$(cat $PID_PATH_NAME);
			 echo "$SERVICE_NAME stoping ..."
			 kill $PID;
			 echo "$SERVICE_NAME stopped ..."
			 rm $PID_PATH_NAME
	  else
			 echo "$SERVICE_NAME is not running ..."
	  fi
	;;  
	restart)
	  if [ -f $PID_PATH_NAME ]; then
		  PID=$(cat $PID_PATH_NAME);   
		  echo "$SERVICE_NAME stopping ...";
		  kill $PID;
		  echo "$SERVICE_NAME stopped ...";
		  rm $PID_PATH_NAME
		  echo "$SERVICE_NAME starting ..."
		  nohup java -jar $PATH_TO_JAR /tmp 2>> /dev/null >> /dev/null &
		  echo $! > $PID_PATH_NAME
		  echo "$SERVICE_NAME started ..."
	  else
		  echo "$SERVICE_NAME is not running ..."
		 fi;;
	 esac
else
    echo "$PATH_TO_JAR doesnt exist. Deployment will be terminated"
    exit 2
fi
