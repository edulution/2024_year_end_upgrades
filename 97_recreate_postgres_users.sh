#!/bin/bash

# Recreate Baseline and Kolibri databases and users
# Alter baseline and kolibri users passwords to match environnment variables
sudo -i -u postgres psql <<-EOF
	drop database if exists baseline_testing;
	create database baseline_testing;
	drop database if exists kolibri;
	create database kolibri;
	alter user baseline_testing with password '$BASELINE_DATABASE_PASSWORD';
	alter user kolibri with password '$KOLIBRI_DATABASE_PASSWORD';
EOF