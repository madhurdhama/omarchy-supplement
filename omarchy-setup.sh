omarchy-install-terminal kitty
omarchy-install-dev-env python
omarchy-install-vscode

sed -i \
  -e 's/^env = GDK_SCALE,2$/env = GDK_SCALE,1/' \
  -e 's/^monitor=,preferred,auto,auto$/monitor=,1920x1080@60,auto,1.25/' \
  ~/.config/hypr/monitors.conf