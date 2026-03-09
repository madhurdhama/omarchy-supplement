#!/bin/bash
set -euo pipefail

THEME_NAME="sddm-astronaut-theme"
THEME_REPO="https://github.com/Keyitdev/sddm-astronaut-theme.git"
THEMES_DIR="/usr/share/sddm/themes"
TMP_DIR="/tmp/$THEME_NAME"
METADATA="$THEMES_DIR/$THEME_NAME/metadata.desktop"

VARIANTS=(
    "astronaut"
    "black_hole"
    "cyberpunk"
    "hyprland_kath"
    "jake_the_dog"
    "japanese_aesthetic"
    "pixel_sakura"
    "pixel_sakura_static"
    "post-apocalyptic_hacker"
    "purple_leaves"
)

echo "==> Installing dependencies..."
sudo pacman --needed -S sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg git

echo "==> Disabling autologin (if present)..."
AUTOLOGIN_FILE="/etc/sddm.conf.d/autologin.conf"
if [[ -f "$AUTOLOGIN_FILE" ]]; then
    sudo sed -i '/^\[Autologin\]/,/^$/ {
        /^[^#]/ s/^/#/
    }' "$AUTOLOGIN_FILE"
fi

echo "==> Cloning theme..."
rm -rf "$TMP_DIR"
git clone --depth 1 "$THEME_REPO" "$TMP_DIR"

echo "==> Installing theme..."
sudo rm -rf "$THEMES_DIR/$THEME_NAME"
sudo mkdir -p "$THEMES_DIR/$THEME_NAME"
sudo cp -r "$TMP_DIR"/* "$THEMES_DIR/$THEME_NAME/"

echo "==> Select theme variant:"
select variant in "${VARIANTS[@]}"; do
    if [[ -n "$variant" ]]; then
        echo "Selected: $variant"
        break
    fi
done

echo "==> Applying variant..."
sudo sed -i "s|^ConfigFile=.*|ConfigFile=Themes/${variant}.conf|" "$METADATA"

echo "==> Setting SDDM theme..."
sudo mkdir -p /etc/sddm.conf.d
sudo sed -i "s/^Current=.*/Current=$THEME_NAME/" /etc/sddm.conf.d/autologin.conf

echo "Done. Reboot required."
