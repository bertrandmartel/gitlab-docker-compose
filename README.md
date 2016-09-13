# Gitlab CE docker compose 

A fully configurable gitlab CE docker-compose build 

It include a feature to generate a self-signed certificate

## Docker-compose

* edit vars-template with your own configuration (see below)

* source & launch

```
source vars-template.sh
docker-compose up
```

## Configuration

This configuration is editable in `vars-template.sh` that must be sourced before running docker-compose :

| Variable name                    |  description       | sample value                                      |
|----------------------------------|---------------------------------|------------------------------------------------------------------------|
| GITLAB_HTTP_INTERNAL_PORT        | http port   | 4242       |
| GITLAB_HTTP_HOST_PORT            | http port exposed to host  | 4343                                                                   |
| GITLAB_EXTERNAL_URL              | external url                               | https://com.example.host:4242                                          |
| GITLAB_SHELL_PORT                | ssh port (you can use custom port)                                | 8022                                                                   |
| GITLAB_REDIRECT_HTTPS            | specify if http redirected to https                                | true                                                                   |
| GITLAB_SSL_CERT                  | ssl server cert path                                | /etc/gitlab/ssl/gitlab.crt                                             |
| GITLAB_SSL_KEY                   | ssl server key path                                | /etc/gitlab/ssl/gitlab.key                                             |
| GITLAB_CERT_SUBJECT              | ssl cert subject (for self signed)                               | (*) |
| GITLAB_SMTP_ENABLE               | enable smtp                                | true                                                                   |
| GITLAB_SMTP_ADDRESS              | smtp address                                | smtp.gmail.com                                                         |
| GITLAB_SMTP_PORT                 | smtp port                                | 587                                                                    |
| GITLAB_SMTP_USER_NAME            | email used                                | your_mail@gmail.com                                                    |
| GITLAB_SMTP_PASSWORD             | email password                                | your_password                                                          |
| GITLAB_SMTP_DOMAIN               | smtp domain                                | smtp.gmail.com                                                         |
| GITLAB_SMTP_AUTHENTICATION       | smtp authentication used                                | login                                                                  |
| GITLAB_SMTP_ENABLE_STARTTLS_AUTO | start TLS enabled for smtp                                | true                                                                   |
| GITLAB_SMTP_TLS                  | use TLS for smtp                                | false                                                                  |
| GITLAB_SMTP_OPENSSL_VERIFY_MODE  | smptp verify mode                                | peer                                                                   |
| GITLAB_GIT_BASIC_AUTH_ENABLED    | basic authentication for gitlab                                | true                                                                   |
| GITLAB_GIT_BASIC_AUTH_MAX_RETRY  | max retry for passowrd attempt                                | 10                                                                     |
| GITLAB_GIT_BASIC_AUTH_FIND_TIME  | number of time allowed before ban                                | 60                                                                     |
| GITLAB_GIT_BASIC_AUTH_BAN_TIME   | ban time                                 | 3600                                                                   |
| REGENERATE_CERT                  | specify if cert should be regenerated each build                                | false                                                                  |
| GENERATE_SELF_SIGNED_CERT        | specify to generate self signed certificates                                | true                                                                   |

(*) /C=FR/ST=Paris/L=Paris/O=GlobalSecurity/OU=ITDepartment/CN=example.com

## Docker-cloud

There is no generation of self-signed certificates on runtime with stackfile. For using SSL, place your certs in `${USER_PATH}/gitlab/config/ssl` directory on your host before deploying :

```
source vars-template.sh
export USER_PATH=/home/bobby
envsubst < stackfile-template.yml > stackfile.yml
```

* revise your `stackfile.yml` file before creating/updating the stack :

```
# create the stack :

docker-cloud stack create --name gitlab-ce -f stackfile.yml

# or update :

docker-cloud stack update -f stackfile.yml <uuid>
```

* start/deploy :

```
# start the stack :

docker-cloud stack start <uuid>

# or redeploy :

docker-cloud stack redeploy <uuid>
```

## External links

* restore gitlab backups : https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/raketasks/backup_restore.md