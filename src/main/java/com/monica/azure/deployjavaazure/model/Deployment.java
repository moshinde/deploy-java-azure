package com.monica.azure.deployjavaazure.model;

public class Deployment {
    private String clientAddress;
    private String serverAddress;
    private String packageVersion;

    public Deployment() {}

    public Deployment(String clientAddress, String serverAddress, String packageVersion) {
      this.clientAddress = clientAddress;
      this.serverAddress = serverAddress;
      this.packageVersion = packageVersion;
    }

    public String getClientAddress() {
        return this.clientAddress;
    }

    public void setClientAddress(String clientAddress) {
        this.clientAddress = clientAddress;
    }

    public String getServerAddress() {
        return this.serverAddress;
    }

    public void setServerAddress(String serverAddress) {
        this.serverAddress = serverAddress;
    }

    public String getPackageVersion() {
        return this.packageVersion;
    }

    public void setPackageVersion(String packageVersion) {
        this.packageVersion = packageVersion;
    }

}