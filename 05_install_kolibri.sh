#!/bin/bash

# remove kolibri directory
rm -rf ~/.kolibri

# copy latest Kolibri whl to opt directory
sudo cp kolibri-0.16.0.dev0+git.20241202205114-py2.py3-none-any.whl /opt/

# Switch to the kolibri virtual environment
workon kolibri

# Store the path to the latest whl file in a variable
LATEST_KOLIBRI_WHL=$( ls /opt/*.whl -t | head -n1 )

# Install the latest whl file in the virtualenv
pip install $LATEST_KOLIBRI_WHL

# Start Kolibri for the first time
kolibri start

# Copy the options file
cp options.ini ~/.kolibri