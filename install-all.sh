#!/bin/bash

# Install all packages in order
./install-packages.sh
./install-dotfiles.sh
./omarchy-setup.sh

# Disable autologin and change sddm theme
# Run with ./install-all.sh sddm
if [[ "$1" == "sddm" ]]; then
    echo "Running SDDM theme install script..."
    ./install-sddm.sh
else
    echo "Skipping SDDM theme install"
fi