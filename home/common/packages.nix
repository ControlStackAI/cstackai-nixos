{
  pkgs,
  lib,
  ...
}: let
  # Add new packages here.
  # Keep this file as the single obvious place to extend your user environment.
  fonts = [
    # Fonts (Ghostty config expects this font family)
    pkgs."nerd-fonts"."jetbrains-mono"
  ];

  cli = with pkgs; [
    # Modern replacements for common commands
    eza # Modern replacement for ls
    bat # Modern replacement for cat
    ripgrep # Modern replacement for grep (rg)
    fd # Modern replacement for find
    fzf # Fuzzy finder
    zoxide # Smart directory jumper (z command)

    # Additional useful tools
    htop # Process monitor
    tree # Directory tree viewer
    wget # File downloader
    curl # HTTP client
    jq # JSON processor

    # System utilities
    neofetch # System info
    zip # Archive tool
    unzip # Archive tool
  ];

  notifications = with pkgs; [
    libnotify # provides notify-send
    swaynotificationcenter # swaync + swaync-client
  ];

  desktop = with pkgs; [
    hyprlock
    hyprpaper

    # Overlay tools / launchers
    wofi

    # Desktop apps referenced by Hyprland config / session defaults
    vivaldi
    kdePackages.dolphin

    # Hyprland keybind dependencies
    brightnessctl
    playerctl

    # Wayland clipboard + portals (screen sharing / file pickers)
    wl-clipboard
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk

    # Polkit agent (autostarted by Hyprland)
    lxqt.lxqt-policykit

    # Remote Desktop
    anydesk
  ];

  dev = with pkgs; [
    git # Version control
    gh # GitHub CLI
    delta # Git diff pager
    ghostty # Terminal emulator
  ];

  k8s = with pkgs; [
    # Kubernetes/Helm tooling
    kubectl
    kubernetes-helm
    k9s
    kubectx
    kustomize
    stern
  ];

  warpWayland = pkgs.writeShellScriptBin "warp-wayland" ''
    #!/usr/bin/env bash
    set -euo pipefail

    # Prefer Wayland for Warp (winit)
    export WINIT_UNIX_BACKEND=wayland

    # Also help other toolkits if Warp spawns anything (harmless if unused)
    export QT_QPA_PLATFORM=wayland
    export GDK_BACKEND=wayland
    export ELECTRON_OZONE_PLATFORM_HINT=wayland

    exec warp-terminal "$@"
  '';

  all = fonts ++ cli ++ notifications ++ desktop ++ dev ++ k8s ++ [warpWayland];
in {
  # Ensure user-installed fonts are discoverable
  fonts.fontconfig.enable = true;

  home.packages = lib.lists.unique all;
}
