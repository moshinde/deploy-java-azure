# deploy-java-azure

This application is created to test Azure pipeline with Deployment group job for java applications. Service simply returns following values on calling http://localhost:8080/gethost :
1. Server address on which this app is deployed
2. The version of service deployed
3. Client address

Application is deployed on EC2 instances.

## Server Provisioning

Use provisionServer.sh file. This file can be configured in the template for EC2 Auto-scaling.

## Azure Build Pipeline

Configure azure-pipeline.yml to setup the build pipeline in Azure

## Azure Deployment Group

Create Azure Deployment group and register all the needed servers by executing powershell which was generated.

## Azure Release pipeline
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

