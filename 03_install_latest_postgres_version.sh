#!/bin/bash

# uninstall existing postgresql
sudo apt remove --purge postgresql-*

# add postgres repository to sources
sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg

# update packages list
sudo apt update

# install latest postgresql
sudo apt install -y postgresql postgresql-contrib

# set up postgres users
sudo -i -u postgres createuser -w -s -e kolibri

sudo -i -u postgres createuser -w -s -e baseline_testing

# create the baseline_testing and kolibri databases
# set password for kolibri and baseline database users using environment variables

sudo -i -u postgres psql <<-EOF
	drop database if exists baseline_testing;
	drop database if exists kolibri;
	create database baseline_testing;
	create database kolibri;
	alter user baseline_testing with password '$BASELINE_DATABASE_PASSWORD';
	alter user kolibri with password '$KOLIBRI_DATABASE_PASSWORD';
	EOF