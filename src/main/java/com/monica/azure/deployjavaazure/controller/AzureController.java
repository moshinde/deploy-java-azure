package com.monica.azure.deployjavaazure.controller;
import java.net.InetAddress;
import javax.servlet.http.HttpServletRequest;
import com.monica.azure.deployjavaazure.model.Deployment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.info.BuildProperties;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AzureController {
    @Autowired
    BuildProperties buildProperties;
       
    @RequestMapping(value="/gethost", method=RequestMethod.GET)
	public Deployment requestMethodName(final HttpServletRequest request) {
        final String clientAddress=request.getServerName();
        Deployment deployment = new Deployment();
        try{
            InetAddress serverAddress;
            serverAddress= InetAddress.getLocalHost();
            deployment.setClientAddress(clientAddress);
            deployment.setServerAddress(serverAddress.toString());
            deployment.setPackageVersion(buildProperties.getVersion());
            return deployment;
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
	}
}
