# README

[ldu-devops-docker](https://lildutils.hu/projects/ldu-devops-docker/about.html)

---

## Overview

Overview is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

---

## Development

Development is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

### PreRequisites

- [Git](https://git-scr.com/download) - git version ^2.34.1
- [GNU Make](https://www.gnu.org/software/make/#download) - GNU Make ^4.3

### Watcher

Watcher Task is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

``` sh
make watch
```

---

## Test

Test is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

### Unit

Unit Test Task is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

``` sh
make test
```

### End-to-End

End to End Test Task is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

``` sh
make e2e
```

---

## Build

Build is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Build Task is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

``` sh
make build
```

---

## Getting Started

Getting Started is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

### Services

Services is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

### *List of Docker Compose Services*

|     | **Service**  | **Image**                                | **Port(s)** |
|----:|:-------------|:-----------------------------------------|------------:|
|   1 | portainer    | portainer/portainer-ce:2.17.1-alpine     |        6061 |
|   2 | nginx        | jc21/nginx-proxy-manager:2.10.0          | 80,443,6062 |
|   3 | vscode       | linuxserver/code-server:4.11.0           |        6063 |
|   4 | mysql        | mysql:8-debian                           |  3306,33060 |
|   5 | phpmyadmin   | phpmyadmin:5.2.1-apache                  |        6064 |
|   6 | postgres     | postgres:15-alpine                       |        5432 |
|   7 | pgadmin      | dpage/pgadmin4:6.21                      |        6065 |
|   8 | mongodb      | mongo:4-focal                            |       27017 |
|   9 | mongoxpress  | mongo-express:1.0.0-alpha                |        6066 |
|  10 | gitlab       | gitlab/gitlab-ce:15.10.0-ce.0            |          80 |
|  11 | gitlabrunner | gitlab/gitlab-runner:alpine3.15-v15.10.0 |           - |
|  12 | sonarqubedb  | postgres:15-alpine                       |        5432 |
|  13 | sonarqube    | sonarqube:9.9.0-community                |        9000 |
|  14 | rabbitmq     | rabbitmq:3-management-alpine             |        6067 |

### Auto-Install

Auto-Install is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

``` sh
bash <(curl -sL https://raw.githubusercontent.com/lildutils/ldu-devops-docker/master/dist/latest/make.sh)
```

### Download to AnyWhere

Download to AnyWhere is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

``` sh
curl -sL https://raw.githubusercontent.com/lildutils/ldu-devops-docker/master/dist/latest/make.sh -o /path/to/make.sh
```

### Configurations

Configurations is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

#### Application

Application Configurations is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

``` ini
CRON_BACKUP_INSTANCES=comma separated list of: devops,portainer,nginx,vscode,mysql,postgres,mongodb,gitlab,sonarqube
CRON_BACKUP_MODES=comma separated list of: daily,weekly,monthly
DEBUG_MODE=showing debug informations: TRUE|FALSE
DIR_DEVOPS=devops directory path
DIR_DEVOPS_BACKUPS=backups directory path
DIR_DEVOPS_DATA=data directory path
FAIL2BAN_MAX_RETRY=integer value to maximalize the login retries
FILE_DEVOPS_ENV=url to auto-download docker-compose .env file
FILE_DEVOPS_COMPOSE=url to auto-download docker-compose .yml file
FILE_DEVOPS_MAKE=url to auto-download makefile
UFW_ALLOW_IN=comma separated list of ports (f.e.: 80,443,22)
UFW_ALLOW_OUT=comma separated list of ports (f.e.: 80,443,53,631)
```

#### Docker Compose Services

Docker Compose Service Configurations is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

``` env
__A__=________________________________________________________________________________
__B__=________________________________________________________________________________
__C__=________________________________________________________________________________
__D__=________________________________________________________________________________
DOMAIN=domain name of the server
__E__=________________________________________________________________________________
__F__=________________________________________________________________________________
__G__=________________________________________________________________________________
GITLAB_ROOT_USER=username
GITLAB_ROOT_PASSWORD=password
GITLAB_EXTERNAL_URL=http(s) schema url of the gitlab service
GITLAB_EXTERNAL_DOMAIN=only domain name of the gitlab service
GITLAB_RUNNER_REGISTRATION_TOKEN=runner registration token of gitlab service
GITLAB_SMTP_ENABLED=true|false, if true the smpt server is enabled in gitlab service
GITLAB_SMTP_SERVER=smtp server domain
GITLAB_SMTP_PORT=465|587|25
GITLAB_SMTP_USER=useremail
GITLAB_SMTP_PASSWORD=password
GITLAB_SMTP_DOMAIN=smtp server allowed domain
GITLAB_SMTP_FROM=gitlab@smtp server allowed domain
GITLAB_SMTP_REPLY=noreply@smtp server allowed domain
__H__=________________________________________________________________________________
__I__=________________________________________________________________________________
__J__=________________________________________________________________________________
__K__=________________________________________________________________________________
__L__=________________________________________________________________________________
__M__=________________________________________________________________________________
MONGO_ROOT_USER=username
MONGO_ROOT_PASSWORD=password
MYSQL_ROOT_USER=username
MYSQL_ROOT_PASSWORD=password
__N__=________________________________________________________________________________
NGINX_ROOT_USER=admin@example.com
NGINX_ROOT_PASSWORD=changeme
__O__=________________________________________________________________________________
__P__=________________________________________________________________________________
PORTAINER_ROOT_USER=username
PORTAINER_ROOT_PASSWORD=password
POSTGRES_ROOT_USER=username
POSTGRES_ROOT_PASSWORD=password
POSTGRES_PGADMIN_USER=useremail
POSTGRES_PGADMIN_PASSWORD=password
__Q__=________________________________________________________________________________
__R__=________________________________________________________________________________
RABBITMQ_ROOT_USER=root
RABBITMQ_ROOT_PASSWORD=password
RABBITMQ_VHOST=local
__S__=________________________________________________________________________________
SONARQUBE_ROOT_USER=admin
SONARQUBE_ROOT_PASSWORD=admin
SONARQUBE_DB_USER=sonar
SONARQUBE_DB_PASSWORD=password
__T__=________________________________________________________________________________
__U__=________________________________________________________________________________
__V__=________________________________________________________________________________
VSCODE_ROOT_USER=username
VSCODE_ROOT_PASSWORD=password
VSCODE_SUDO_USER=my username
VSCODE_SUDO_PASSWORD=my password
VSCODE_SUDO_PUID=my user-id
VSCODE_SUDO_PGID=my group-id
VSCODE_WORKSPACE=path to my home directory
__W__=________________________________________________________________________________
__X__=________________________________________________________________________________
__Y__=________________________________________________________________________________
__Z__=________________________________________________________________________________
```

### Usage

Usage is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

``` sh
/path/to/make.sh --help
```

### LDT compatibility

LDT compatibility is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

``` sh
ldt devops --help
```

---
###### Have a good DevOPSing! (:

##### Bests,
##### d
