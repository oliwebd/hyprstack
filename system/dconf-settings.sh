#!/usr/bin/env bash
set -euo pipefail

# This script sets GTK themes for the Hyprland session via gsettings.
# It uses dconf but restricts the changes to ensure it doesn't break GNOME defaults if possible.

# Apply Catppuccin theme to GTK 3/4
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
gsettings set org.gnome.desktop.interface font-name 'Inter 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 10'

# Ensure Wayland portal is configured
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:'

echo "dconf GTK settings applied."
