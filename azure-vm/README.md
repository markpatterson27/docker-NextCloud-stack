# NextCloud on Azure VM

Docker compose stack for running NextCloud on an Azure VM. Let's Encrypt is used for SSL certificate management and DuckDNS for dynamic DNS.

## Requirements

- Azure account
- [DuckDNS](https://duckdns.org) account
- Azure CLI

## Setup

1. Create an Azure VM
    
    This can be done by running the deployment script.

    ```powershell
    .\deploy.ps1
    ```

2. SSH into the VM

    ```powershell
    ssh <username>@<public-ip>
    ```

3. Before running the stack the following environment variables need to be set:

    ```bash
    export DUCKDNS_TOKEN=<duckdns-token>
    export DUCKDNS_DOMAIN=<duckdns-domain>
    export LETSENCRYPT_EMAIL=<email>
    ```

4. Run the stack

    ```bash
    docker-compose up -d
    ```

5. Access NextCloud

    Open a browser and navigate to `https://<duckdns-domain>.duckdns.org`

6. Configure NextCloud

    Follow the setup wizard to configure NextCloud.




## References

- NextCloud Docker: https://hub.docker.com/_/nextcloud
- https://blog.jarrousse.org/2022/11/01/a-docker-first-solution-to-running-nginx-reverse-proxy-with-automatically-updated-lets-encrypt-ssl-certificates-using-nginx-proxy-and-acme-companion/
