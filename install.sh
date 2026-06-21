#!/usr/bin/env bash
set -euo pipefail

echo "========================================="
echo "  Hyprland Dotfiles Installer (Fedora)   "
echo "========================================="

# Ensure running on Fedora
if ! grep -q "Fedora" /etc/os-release; then
    echo "Error: This script is optimized for Fedora Linux."
    exit 1
fi

echo ">> Updating system..."
sudo dnf upgrade -y

echo ">> Enabling RPM Fusion..."
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
                    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo ">> Enabling ashbuk/Hyprland-Fedora COPR (F44 compatible)..."
sudo dnf copr enable -y ashbuk/Hyprland-Fedora

echo ">> Installing core Hyprland packages and UWSM..."
sudo dnf install -y hyprland uwsm hyprlock hypridle xdg-desktop-portal-hyprland

echo ">> Installing desktop components..."
sudo dnf install -y waybar wofi kitty swaync swww \
                    grim slurp swappy wl-clipboard cliphist \
                    polkit-gnome network-manager-applet pavucontrol \
                    blueman brightnessctl playerctl jq yazi

echo ">> Installing fonts and themes..."
sudo dnf install -y jetbrains-mono-fonts \
                    fontawesome-fonts \
                    google-inter-fonts \
                    papirus-icon-theme \
                    adw-gtk3-theme

echo ">> Installation complete."
echo ">> Running bootstrap.sh to configure dotfiles..."

# Determine the absolute path of the repository
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run bootstrap
if [[ -f "$REPO_DIR/bootstrap.sh" ]]; then
    bash "$REPO_DIR/bootstrap.sh"
else
    echo "Warning: bootstrap.sh not found."
fi

echo "========================================="
echo "  Setup complete! Reboot and select      "
echo "  Hyprland (UWSM) from GDM.              "
echo "========================================="
