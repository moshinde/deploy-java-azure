# deploy-java-azure

This service is created to test Azure pipeline with Deployment group job for java applications. Service simply returns following values on calling http://localhost:8080/gethost :
1. Server address on which this app is deployed
2. The version of service deployed
3. Client address

Application is deployed on EC2 instances with load balancing using AWS ELB and AWS Autoscaling group.

## Create Azure Deployment Group

Create Azure Deployment group and copy shell which was generated.
Paste it in the provisionServer.sh

## Server Provisioning

Use provisionServer.sh file to provision servers. This file can be configured in the template for EC2 Auto-scaling group. This will provision servers with all the needed applications to run this service and also will register the server with Azure deployment group as an agent.

Update arguement provided in the provisionServer.sh file for "--token *****"

## Azure Build Pipeline

Configure azure-pipeline.yml to setup the build pipeline in Azure. This includes following tasks:
1. Unit testing
2. maven clean install
3. Publish of jar file as pipeline artifacts

To pass build number to pom.xml from build pipeline. Code from azure-pipeline.yml
```bash
options: '-DpackageVersion="$(Build.BuildNumber)" -DskipTests'
```

To make use of build number as jar version. Code from pom.xml
```bash
<version>${packageVersion}</version>
```

This pipeline includes following trigger:
1. Continuous integration: With every push to master branch pipeline will be triggered
2. Pull request validation: Validate the PR against master branch


## Azure Release pipeline

This includes deployment group job.
