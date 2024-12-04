#!/bin/bash

# Make backups of postgresql configuration files
sudo cp /etc/postgresql/17/main/pg_hba.conf /etc/postgresql/17/main/pg_hba.conf.bak
sudo cp /etc/postgresql/17/main/postgresql.conf /etc/postgresql/17/main/postgresql.conf.bak

# Do replacement to allow any listen address and allow authentication with md5
sudo sed -i 's|^host\s\+all\s\+all\s\+127\.0\.0\.1/32\s\+scram-sha-256$|host    all             all             0.0.0.0/0            md5|' /etc/postgresql/17/main/pg_hba.conf
sudo sed -i "s|^#listen_addresses\s*=\s*'localhost'\s*#.*$|listen_addresses = '*'         # what IP address(es) to listen on;|" /etc/postgresql/17/main/postgresql.conf

