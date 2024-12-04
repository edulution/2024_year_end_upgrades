#!/bin/bash

# Rename the old virtualenv to kolibri_13_virtualenv
sudo mv /opt/kolibri_virtualenv.zip /opt/kolibri_13_virtualenv.zip 

# Copy the new virtualenv to /opt and rename it to kolibri_virtualenv
sudo cp kolibri_16_virtualenv.zip /opt/kolibri_virtualenv.zip 

# Remove old virtualenvs folder from home directory
rm -rf ~/.virtualenvs

# Unzip the new virtualenvs folder into the home directory
unzip -d ~ kolibri_16_virtualenv.zip