{...}: {
  imports = [
    ../../modules/home/ai-web.nix
  ];

  # Enable the AI Web Console service
  services.ai-web.enable = true;

  # Autostart swaync (Sway Notification Center) as a user service
  services.swaync.enable = true;
}
