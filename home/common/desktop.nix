{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Hyprland configuration is kept in focused modules.
    ../../modules/core/hyprland/appearance.nix
    ../../modules/core/hyprland/animations.nix
    ../../modules/core/hyprland/autostart.nix
    ../../modules/core/hyprland/env.nix
    ../../modules/core/hyprland/hyprlock.nix
    ../../modules/core/hyprland/hyprpaper.nix
    ../../modules/core/hyprland/input.nix
    ../../modules/core/hyprland/keybindings.nix
    ../../modules/core/hyprland/monitors.nix
    ../../modules/core/hyprland/programs.nix
    ../../modules/core/hyprland/windowrules.nix

    # Desktop helpers (screenshots/recording scripts)
    ../../modules/home/screenshots.nix
  ];

  # Enable Hyprland config under Home Manager
  wayland.windowManager.hyprland.enable = true;
}
