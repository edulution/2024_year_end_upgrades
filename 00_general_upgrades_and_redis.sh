#!/bin/bash

# Take database backups
backup

# upgrade all packages
sudo apt update -y && sudo apt upgrade -y

# install redis
sudo apt install redis -y

sudo apt autoclean && sudo apt autoremove -y


# upgrade R packages
# sudo su - -c "R -e \"update.packages(checkBuilt = TRUE, ask = FALSE)\""	