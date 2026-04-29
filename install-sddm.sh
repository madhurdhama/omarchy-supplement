#!/bin/bash
set -euo pipefail

THEME_NAME="pixie"
THEME_REPO="https://github.com/xCaptaiN09/pixie-sddm.git"
THEMES_DIR="/usr/share/sddm/themes"
TMP_DIR="/tmp/pixie-sddm"
CONFIG_FILE="/etc/sddm.conf.d/autologin.conf"

echo "==> Installing dependencies..."
sudo pacman --noconfirm --needed -S qt6-declarative qt6-svg qt6-quickcontrols2

echo "==> Disabling autologin (if present)..."
if [[ -f "$CONFIG_FILE" ]]; then
    sudo sed -i '/^\[Autologin\]/,/^$/ {
        /^[^#]/ s/^/#/
    }' "$CONFIG_FILE"
fi

echo "==> Cloning theme..."
rm -rf "$TMP_DIR"
git clone --depth 1 "$THEME_REPO" "$TMP_DIR"

echo "==> Installing theme..."
sudo rm -rf "$THEMES_DIR/$THEME_NAME"
sudo cp -r "$TMP_DIR" "$THEMES_DIR/$THEME_NAME"

echo "==> Setting SDDM theme..."
sudo sed -i "/^\[Theme\]/,/^$/ s/^Current=.*/Current=$THEME_NAME/" "$CONFIG_FILE"

echo "==> Cleaning up..."
rm -rf "$TMP_DIR"

echo "✅ Done. Reboot required."