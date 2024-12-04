#!/bin/bash

# upgrade R packages
sudo su - -c "R -e \"update.packages(checkBuilt = TRUE, ask = FALSE)\""	