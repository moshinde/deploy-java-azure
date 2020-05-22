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
 ExecStart =/bin/bash /usr/local/bin/deploy.sh start
 ExecStop =/bin/bash /usr/local/bin/deploy.sh stop
 ExecReload =/bin/bash /usr/local/bin/deploy.sh restart
[Install]
 WantedBy=multi-user.target
EOF
echo "Switching user"
su -  azagentuser bash -c 'mkdir azagent;cd azagent;curl -fkSL -o vstsagent.tar.gz https://vstsagentpackage.azureedge.net/agent/2.168.2/vsts-agent-linux-x64-2.168.2.tar.gz;tar -zxvf vstsagent.tar.gz; if [ -x "$(command -v systemctl)" ]; then ./config.sh --deploymentgroup --deploymentgroupname "Java-service-DEV" --acceptteeeula --agent $HOSTNAME --addDeploymentGroupTags --deploymentGroupTags "dev" --url https://dev.azure.com/MonicaShinde1307/ --work _work --projectname 'RockNRollTrain' --auth PAT --token ***** --runasservice; sudo ./svc.sh install; sudo ./svc.sh start; else ./config.sh --deploymentgroup --deploymentgroupname "Java-service-DEV" --acceptteeeula --agent $HOSTNAME --addDeploymentGroupTags --deploymentGroupTags "dev" --url https://dev.azure.com/MonicaShinde1307/ --work _work --projectname 'RockNRollTrain' --auth PAT --token *****; ./run.sh; fi'
echo "Done agent registration"
