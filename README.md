# Hyprland Dotfiles for Fedora 44

A production-grade, Wayland-only Hyprland dotfiles repository optimized for Fedora 44. It is designed to perfectly co-exist with GNOME 50 without breaking any GNOME components.

## Features
- **Compositor:** Hyprland
- **Session Management:** UWSM (Universal Wayland Session Manager)
- **Bar:** Waybar
- **Launcher:** Wofi
- **Terminal:** Kitty
- **Notifications:** SwayNC
- **Theme:** Catppuccin Mocha
- **Idle/Lock:** hypridle / hyprlock
- **Wallpaper:** swww

## Installation

> [!WARNING]
> This setup requires a COPR repository (`solopasha/hyprland`) on Fedora 44 since Hyprland and UWSM are not in the official Fedora 44 repositories.

Run the interactive installer script to set up dependencies, enable COPRs, and configure your system:

```bash
./install.sh
```

## Structure
- `config/`: Contains all XDG configuration files (Hyprland, Waybar, Wofi, etc.).
- `scripts/`: Helper bash scripts for volume, wallpaper, and screenshots.
- `system/`: System-level configurations, environment variables, and DCONF settings.
- `themes/`: Reusable theme palettes and component stylesheets.
- `assets/`: Wallpapers, fonts, and icons.

## GNOME Co-existence
This repository avoids touching anything in `~/.config/gtk-3.0/` or `~/.config/gtk-4.0/` directly if it would break GNOME. Instead, it relies on `dconf` settings scoped to the Hyprland session where possible, and UWSM to handle environment variables perfectly so they do not leak into GDM or GNOME sessions.
