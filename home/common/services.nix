{...}: {
  imports = [
    ../../modules/home/ai-web.nix
  ];

  # Enable the AI Web Console service
  services.ai-web.enable = true;

  # NOTE:
  # Swaync only works under Wayland and will fail if Home Manager tries to start it
  # as a systemd user service outside an active Wayland session (e.g. during SSH
  # activation or on X11).
  #
  # We start swaync via Hyprland `exec-once` (see modules/core/hyprland/autostart.nix)
  # instead, so it launches in the right environment.
  services.swaync.enable = false;
}
