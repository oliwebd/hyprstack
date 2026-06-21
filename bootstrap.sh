#!/usr/bin/env bash
set -euo pipefail

echo ">> Bootstrapping dotfiles..."

# Determine the absolute path of the repository
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

# Ensure XDG dirs exist
xdg-user-dirs-update

# Function to symlink directories safely
link_config() {
    local source_dir="$1"
    local target_name="$2"
    
    if [[ -d "$CONFIG_DIR/$target_name" && ! -L "$CONFIG_DIR/$target_name" ]]; then
        echo "   Backing up existing $target_name to ${target_name}.bak"
        mv "$CONFIG_DIR/$target_name" "$CONFIG_DIR/${target_name}.bak"
    fi
    
    if [[ ! -L "$CONFIG_DIR/$target_name" ]]; then
        echo "   Symlinking $target_name"
        ln -s "$REPO_DIR/config/$source_dir" "$CONFIG_DIR/$target_name"
    else
        echo "   $target_name already symlinked."
    fi
}

mkdir -p "$CONFIG_DIR"

# Link all config components
link_config "hypr" "hypr"
link_config "waybar" "waybar"
link_config "wofi" "wofi"
link_config "kitty" "kitty"
link_config "swaync" "swaync"
link_config "hyprlock" "hyprlock"
link_config "hypridle" "hypridle"
link_config "uwsm" "uwsm"

# Run the system setup scripts (like dconf settings)
if [[ -f "$REPO_DIR/system/dconf-settings.sh" ]]; then
    echo ">> Applying GTK/dconf settings..."
    bash "$REPO_DIR/system/dconf-settings.sh"
fi

# Install custom fonts
echo ">> Installing custom fonts from assets/fonts/..."
mkdir -p "$HOME/.local/share/fonts"
cp -r "$REPO_DIR/assets/fonts/"*.ttf "$HOME/.local/share/fonts/" 2>/dev/null || true
fc-cache -f

echo ">> Bootstrap complete."
