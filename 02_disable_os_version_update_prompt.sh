#!/bin/bash

# Disable prompt to update OS to latest version
sudo sed -i 's/Prompt=.*/Prompt=never/' /etc/update-manager/release-upgrades
