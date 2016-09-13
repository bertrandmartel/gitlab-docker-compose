#!/bin/bash

function write_message()
{
	if [ "$1" == 0 ]; then
		echo -ne "\x1B[31m"
	else
		echo -ne "\x1B[01;32m"
	fi
	echo "$2"
	echo -ne "\x1B[0m"
}

echo -ne "\x1B[0m"

if [ "$5" == false ]; then
	write_message 0 "wont generate self signed certificates..."
	exit;
fi

if [ -z "$1" ]; then
	write_message 0 "output path of public cert is missing (ex: export GITLAB_SSL_CERT=/etc/gitlab/ssl/gitlab.crt)"
fi

if [ -z "$2" ]; then
	write_message 0 "output path of private key cert is missing (ex: export GITLAB_SSL_KEY=/etc/gitlab/ssl/gitlab.key)"
fi

if [ -z "$3" ]; then
	write_message 0 "certificate subject is missing (ex: export GITLAB_CERT_SUBJECT=/C=FR/ST=Paris/L=Paris/O=GlobalSecurity/OU=ITDepartment/CN=example.com)"
fi

if [ ! -z "$1" ] && [ ! -z "$2" ] && [ ! -z "$3" ] ; then

	if [ "$4" = false ] && [ -f $1 ] && [ -f $2 ]; then
		write_message 0 "certificates exist. wont regenerate them..."
		exit;
	fi

	CRT_DIR=$(dirname "$1")
	KEY_DIR=$(dirname "$2")
	mkdir -p $CRT_DIR
	mkdir -p $KEY_DIR

	write_message 1 "generating self signed server certificates..."
	openssl req  -nodes -new -x509  -keyout $2 -out $1 -subj "$3"
	write_message 1 "_ public  cert has been put in $1"
	write_message 1 "_ private cert has been put in $2"
else
	write_message 0 "self signed certificates wont be generated"
fi

echo -ne "\x1B[0m"