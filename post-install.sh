#!/bin/bash

# Add tmux keybind if missing
BIND_LINE='bind -x '"'"'"\C-f":"$HOME/.config/tmux/tmux-sessionizer"'"'"
grep -Fxq "$BIND_LINE" ~/.bashrc || echo "$BIND_LINE" >> ~/.bashrc

# Hyprland monitor scaling
sed -i \
  -e 's/^env = GDK_SCALE,2$/env = GDK_SCALE,1/' \
  -e 's/^monitor=,preferred,auto,auto$/monitor=,1920x1080@60,auto,1.25/' \
  ~/.config/hypr/monitors.conf

# Ghostty font size
sed -i 's/^font-size = .*/font-size = 11/' ~/.config/ghostty/config