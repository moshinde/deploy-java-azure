#!/bin/bash
yum update -y
yum install git -y
yum install java-1.8.0-openjdk -y
yum install maven -y
adduser azagentuser
echo "azagentpwd" | passwd --stdin azagentuser
echo 'azagentuser ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers
cat <<EOF > /etc/systemd/system/deploy-java-azure.service
[Unit]
 Description = Java Service
 After network.target = deploy-java-azure.service
[Service]
 Type = forking
 Restart=always
 RestartSec=1
 SuccessExitStatus=143 
 ExecStart =/usr/local/bin/deploy.sh start
 ExecStop =/usr/local/bin/deploy.sh stop
 ExecReload =/usr/local/bin/deploy.sh restart
[Install]
 WantedBy=multi-user.target
EOF
