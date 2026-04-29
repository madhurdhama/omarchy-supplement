#!/bin/bash

# Install all packages in order
./install-packages.sh
./install-dotfiles.sh
./omarchy-setup.sh

# Disable autologin and change sddm theme
echo -e "\e[1;33mDisable autologin and change sddm theme? (y/n):\e[0m"
read answer

if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    echo "Running optional script..."
    ./install-sddm.sh
else
    echo "Skipped"
fi