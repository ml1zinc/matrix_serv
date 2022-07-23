## Docker's Matrix-synapse server
![](https://img.shields.io/badge/shell-bash-black) ![](https://img.shields.io/badge/docker-engine-blue) ![](https://img.shields.io/badge/docker-compose-blue) ![](https://img.shields.io/badge/postgre-SQL-blueviolet) ![](https://img.shields.io/badge/matrix-synapse-white) ![](https://img.shields.io/badge/nginx-service-green) ![](https://img.shields.io/badge/cert-bot-green)
### Used
* [Docker with Docker Compose](https://www.docker.com/)
* [Matrix-synapse](https://matrix.org/docs/projects/server/synapse/)
* [NGINX](https://nginx.org/)
* [PostgreSQL](https://www.postgresql.org/)
* [Cert bot](https://certbot.eff.org/)

## Table of contents
- [Server Installation](#SrvInst)
    - [Make .env File](#envFile)
    - [Create certificates](#createCert)
- [Run project](#Run)
### Server Installation<a id='SrvInst'></a>

* Make dot.env File in directory /home/<your_user>/matrix <a id='envFile'></a>
```
#file .env
POSTGRES_HOST=<you_postgres_host>
POSTGRES_USER=<you_postgres_user>
POSTGRES_PASSWORD=<you_postgres_db_password>
POSTGRES_DB=<you_postgres_db_name>

SYNAPSE_SERVER_NAME=<you_synapse_server_dns_name>
SYNAPSE_REPORT_STATS=yes
SYNAPSE_HTTP_PORT=8008
SYNAPSE_REGISTRATION_SHARED_SECRET=<you_registration_shared_secret>
SYNAPSE_CONFIG_DIR=/data

PREFIX_SERVER_NAME=<prefix_of_dns_name>
DNS_TOKEN=<you_duck_dns_token>

DB_ROLE_PASSWORD=<you_synapse_user_db_role_password>
```
* Create a certificates <a id='createCert'></a>
```
 sudo certbot --nginx -d <you_synapse_server_dns_name> -d www.<you_synapse_server_dns_name> -m <email> --agree-tos --no-eff-email
```
* Put this file in ./nginx/cert:
```
   cert.pem
   chain.pem
   fullchain.pem
   privkey.pem
```
* And this in ./nginx/ssl
```
   options-ssl-nginx.conf
   ssl-dhparams.pem
```
### Run project<a id='Run'></a>
* For simple full setup configuration files (will create matrix configuration file and add values from .env)
```
 sudo make fullsetup
```
* Up docker container
 ```
 make up
```
* Down docker container
 ```
 make down
```
* Down and up docker container
 ```
 make downup
```
* Start docker container
 ```
 make start
```
* Stop docker container
 ```
 make stop
```
* Restart docker container
 ```
 make restart
```                  
* For get last 250 log lines (without ENV return logs for synapse)
```
 make logs ENV=<service_name>
```
