package com.monica.azure.deployjavaazure.controller;

import java.net.InetAddress;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AzureController {
    @RequestMapping(value="/gethost", method=RequestMethod.GET)
	public String requestMethodName(final HttpServletRequest request) {
        final String clientAddress=request.getServerName();
        try{
            InetAddress serverAddress;
            serverAddress= InetAddress.getLocalHost();
            return "Request is comming from : "+clientAddress+" for server with hostname/ip : "+serverAddress;
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
	}
}
