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

| **Service**  | **Image**                                |
|:-------------|:-----------------------------------------|
| portainer    | portainer/portainer-ce:2.17.1-alpine     |
| mongodb      | mongo:4-focal                            |
| mongoxpress  | mongo-express:1.0.0-alpha                |
| mysql        | mysql:8-debian                           |
| phpmyadmin   | phpmyadmin:5.2.1-apache                  |
| postgres     | postgres:15-alpine                       |
| pgadmin      | dpage/pgadmin4:6.21                      |
| vscode       | linuxserver/code-server:4.11.0           |
| nginx        | jc21/nginx-proxy-manager:2.10.0          |
| gitlab       | gitlab/gitlab-ce:15.10.0-ce.0            |
| gitlabrunner | gitlab/gitlab-runner:alpine3.15-v15.10.0 |
| sonarqubedb  | postgres:15-alpine                       |
| sonarqube    | sonarqube:9.9.0-community                |
| registry     | registry:2.8.1                           |
| registryauth | opensuse/portus:2.5                      |
| healthcheck  | linuxserver/healthchecks:2.7.20230324    |

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
CURRDIR=current directory path of makefile
CRON_BACKUP_MODES=comma separated list of: daily | weekly | monthly
DIR_DEVOPS=devops directory path
DIR_DEVOPS_BACKUPS=backups directory path
DIR_DEVOPS_DATA=data directory path
DOCKER_INIT_DB_CLIENTS=comma separated list of: phpmyadmin | pgadmin | mongoxpress
FAIL2BAN_MAX_RETRY=integer value to maximalize the login retries
FILE_DEVOPS_ENV=url to auto-download docker-compose .env file
FILE_DEVOPS_COMPOSE=url to auto-download docker-compose .yml file
FILE_DEVOPS_MAKE=url to auto-download makefile
GITLAB_RUNNER_REGISTRATION_TOKEN=registration-token from gitlab
INIFILENAME=.ini filename of the makefile
MAKEFILENAME=.sh filename of the makefile
UFW_ALLOW_IN=comma separated list of: http | https | ssh
UFW_ALLOW_OUT=comma separated list of: http | https | 53/udp
```

#### Docker Compose Services

Docker Compose Service Configurations is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

``` sh
GITLAB_ROOT_USER=username
GITLAB_ROOT_PASSWORD=password
GITLAB_EXTERNAL_URL=http(s) schema url of the gitlab service
GITLAB_EXTERNAL_DOMAIN=only domain name of the gitlab service
GITLAB_SMTP_ENABLED=true|false, if true the smpt server is enabled in gitlab service
GITLAB_SMTP_SERVER=smtp server domain
GITLAB_SMTP_PORT=465|587|25
GITLAB_SMTP_USER=useremail
GITLAB_SMTP_PASSWORD=password
GITLAB_SMTP_DOMAIN=smtp server allowed domain
GITLAB_SMTP_FROM=gitlab@smtp server allowed domain
GITLAB_SMTP_REPLY=noreply@smtp server allowed domain
MONGO_ROOT_USER=username
MONGO_ROOT_PASSWORD=password
MYSQL_ROOT_USER=username
MYSQL_ROOT_PASSWORD=password
PORTAINER_ROOT_USER=username
PORTAINER_ROOT_PASSWORD=password
POSTGRES_ROOT_USER=username
POSTGRES_ROOT_PASSWORD=password
POSTGRES_PGADMIN_USER=useremail
POSTGRES_PGADMIN_PASSWORD=password
NGINX_DB_USER=username
NGINX_DB_PASSWORD=password
NGINX_SUDO_PGID=$(id -u)
NGINX_SUDO_PUID=$(id -g)
REGISTRY_ROOT_USER=username
REGISTRY_ROOT_PASSWORD=password
SONARQUBE_ROOT_USER=username
SONARQUBE_ROOT_PASSWORD=password
SONARQUBE_DB_USER=username
SONARQUBE_DB_PASSWORD=password
VSCODE_ROOT_USER=username
VSCODE_ROOT_PASSWORD=password
VSCODE_SUDO_USER=username
VSCODE_SUDO_PASSWORD=password
VSCODE_SUDO_PGID=usergroup
VSCODE_SUDO_PUID=usergroup
VSCODE_WORKSPACE=path of the home directory
```

### Usage

Usage is Coming soon... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

``` sh
/path/to/make.sh --help
```

---
###### Have a good DevOPSing! (:

##### Bests,
##### d
