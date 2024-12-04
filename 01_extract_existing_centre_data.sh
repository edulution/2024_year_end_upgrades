#!/bin/bash

mkdir ~/extracted_data
cd ~/extracted_data

PGPASSWORD=$KOLIBRI_DATABASE_PASSWORD psql -h "$KOLIBRI_DATABASE_HOST" -U "$KOLIBRI_DATABASE_USER" -d "$KOLIBRI_DATABASE_NAME" -p "$KOLIBRI_DATABASE_PORT" -c "\COPY (select * from kolibriauth_facilityuser ) TO 'kolibriauth_facilityuser.csv' DELIMITER ',' CSV HEADER;"
PGPASSWORD=$KOLIBRI_DATABASE_PASSWORD psql -h "$KOLIBRI_DATABASE_HOST" -U "$KOLIBRI_DATABASE_USER" -d "$KOLIBRI_DATABASE_NAME" -p "$KOLIBRI_DATABASE_PORT" -c "\COPY (select * from logger_attemptlog ) TO 'logger_attemptlog.csv' DELIMITER ',' CSV HEADER;"
PGPASSWORD=$KOLIBRI_DATABASE_PASSWORD psql -h "$KOLIBRI_DATABASE_HOST" -U "$KOLIBRI_DATABASE_USER" -d "$KOLIBRI_DATABASE_NAME" -p "$KOLIBRI_DATABASE_PORT" -c "\COPY (select * from logger_contentsessionlog ) TO 'logger_contentsessionlog.csv' DELIMITER ',' CSV HEADER;"
PGPASSWORD=$KOLIBRI_DATABASE_PASSWORD psql -h "$KOLIBRI_DATABASE_HOST" -U "$KOLIBRI_DATABASE_USER" -d "$KOLIBRI_DATABASE_NAME" -p "$KOLIBRI_DATABASE_PORT" -c "\COPY (select * from logger_contentsummarylog ) TO 'logger_contentsummarylog.csv' DELIMITER ',' CSV HEADER;"
PGPASSWORD=$KOLIBRI_DATABASE_PASSWORD psql -h "$KOLIBRI_DATABASE_HOST" -U "$KOLIBRI_DATABASE_USER" -d "$KOLIBRI_DATABASE_NAME" -p "$KOLIBRI_DATABASE_PORT" -c "\COPY (select * from logger_masterylog ) TO 'logger_masterylog.csv' DELIMITER ',' CSV HEADER;"
PGPASSWORD=$KOLIBRI_DATABASE_PASSWORD psql -h "$KOLIBRI_DATABASE_HOST" -U "$KOLIBRI_DATABASE_USER" -d "$KOLIBRI_DATABASE_NAME" -p "$KOLIBRI_DATABASE_PORT" -c "\COPY (select * from logger_usersessionlog ) TO 'logger_usersessionlog.csv' DELIMITER ',' CSV HEADER;"

# Changes required to files in order to upload to kolibri v16

# kolibriauth_facilityuser
# deleted	birth_year	exam_number	gender - need to be removed from kolibriauth_facilityuser
# birth_year	gender	id_number	deleted  - need to be added and populated wth dummay variables

# logger_attemptlog
# no changes needed

# logger_contentsummarylog
# no changes needed

# logger_masterylog
# add column time_spent. set to 0

# logger_usersessionlog
# set channels to 0
# set pages to 0
# add column device_info. set to "Linux,x86_64/Chrome,131"

# logger_contentsessionlog
# add column visitor_id. set to same value as user_id
