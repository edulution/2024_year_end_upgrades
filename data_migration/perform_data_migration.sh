#!/bin/bash

./extract_config_vars.sh kolibriauth_facilityuser.csv

./replace_values_with_config_vars.sh -d -f kolibriauth_facilityuser.csv
./replace_values_with_config_vars.sh -d logger_masterylog.csv
./replace_values_with_config_vars.sh -d logger_contentsessionlog.csv
./replace_values_with_config_vars.sh -d logger_contentsummarylog.csv
./replace_values_with_config_vars.sh -d logger_attemptlog.csv
./replace_values_with_config_vars.sh -d logger_usersessionlog.csv


python process_kolibriauth_facilityuser.py processed_kolibriauth_facilityuser.csv
python process_logger_contentsessionlog.py processed_logger_contentsessionlog.csv
python process_logger_masterylog.py processed_logger_masterylog.csv
python process_logger_usersessionlog.py processed_logger_usersessionlog.csv


PGPASSWORD=$KOLIBRI_DATABASE_PASSWORD psql -h "$KOLIBRI_DATABASE_HOST" -U "$KOLIBRI_DATABASE_USER" -d "$KOLIBRI_DATABASE_NAME" -p "$KOLIBRI_DATABASE_PORT" -t -A -F"," -c "\COPY kolibriauth_facilityuser FROM 'processed_kolibriauth_facilityuser.csv' WITH DELIMITER AS ',' CSV HEADER;"
PGPASSWORD=$KOLIBRI_DATABASE_PASSWORD psql -h "$KOLIBRI_DATABASE_HOST" -U "$KOLIBRI_DATABASE_USER" -d "$KOLIBRI_DATABASE_NAME" -p "$KOLIBRI_DATABASE_PORT" -t -A -F"," -c "\COPY logger_contentsummarylog FROM 'processed_logger_contentsummarylog.csv' WITH DELIMITER AS ',' CSV HEADER;"
PGPASSWORD=$KOLIBRI_DATABASE_PASSWORD psql -h "$KOLIBRI_DATABASE_HOST" -U "$KOLIBRI_DATABASE_USER" -d "$KOLIBRI_DATABASE_NAME" -p "$KOLIBRI_DATABASE_PORT" -t -A -F"," -c "\COPY logger_masterylog FROM 'processed_logger_masterylog.csv' WITH DELIMITER AS ',' CSV HEADER;"
PGPASSWORD=$KOLIBRI_DATABASE_PASSWORD psql -h "$KOLIBRI_DATABASE_HOST" -U "$KOLIBRI_DATABASE_USER" -d "$KOLIBRI_DATABASE_NAME" -p "$KOLIBRI_DATABASE_PORT" -t -A -F"," -c "\COPY logger_contentsessionlog FROM 'processed_logger_contentsessionlog.csv' WITH DELIMITER AS ',' CSV HEADER;"	
PGPASSWORD=$KOLIBRI_DATABASE_PASSWORD psql -h "$KOLIBRI_DATABASE_HOST" -U "$KOLIBRI_DATABASE_USER" -d "$KOLIBRI_DATABASE_NAME" -p "$KOLIBRI_DATABASE_PORT" -t -A -F"," -c "\COPY logger_attemptlog FROM 'processed_logger_attemptlog.csv' WITH DELIMITER AS ',' CSV HEADER;"
PGPASSWORD=$KOLIBRI_DATABASE_PASSWORD psql -h "$KOLIBRI_DATABASE_HOST" -U "$KOLIBRI_DATABASE_USER" -d "$KOLIBRI_DATABASE_NAME" -p "$KOLIBRI_DATABASE_PORT" -t -A -F"," -c "\COPY logger_usersessionlog FROM 'processed_logger_usersessionlog.csv' WITH DELIMITER AS ',' CSV HEADER;"