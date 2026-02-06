{
  config,
  pkgs,
  lib,
  ...
}: {
  system.stateVersion = "25.11";

  # Track the newest Nix available in the pinned nixpkgs.
  nix.package = lib.mkDefault pkgs.nixVersions.latest;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Hosts may override kernelPackages in their own config if needed,
  # but we leave the global default to NixOS's built-in choice to avoid
  # duplicate definitions with hardware-specific modules.

  # Enable modern graphics stack on 25.05+
  hardware.graphics.enable = true;
  # hardware.graphics.enable32Bit = true; # Uncomment for 32-bit GL (Steam/Wine)

  # Nix store maintenance and optimisation
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;
}
