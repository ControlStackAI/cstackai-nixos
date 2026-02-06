{
  config,
  pkgs,
  lib,
  ...
}: {
  # Host-specific toggles and imports
  imports = [
    ../../modules/core/networking.nix
    ../../modules/core/bootloader.nix
    ../../modules/core/cloudflare-warp.nix
  ];

  # Enable booting from a bcachefs root filesystem on this host.
  # The actual partitioning and filesystem creation is handled by
  # hosts/controlstackos/disko.nix.
  boot.supportedFilesystems = ["bcachefs"];

  # Mount bcachefs subvolumes for a clean layout and targeted snapshots.
  # The root device/fsType come from hardware-configuration.nix.
  fileSystems."/home" = {
    device = config.fileSystems."/".device;
    fsType = "bcachefs";
    options = ["X-mount.subdir=@home" "noatime"];
  };

  fileSystems."/nix" = {
    device = config.fileSystems."/".device;
    fsType = "bcachefs";
    options = ["X-mount.subdir=@nix" "noatime"];
  };

  fileSystems."/var/log" = {
    device = config.fileSystems."/".device;
    fsType = "bcachefs";
    options = ["X-mount.subdir=@log" "noatime"];
  };

  # Per-host kernel customization examples (override core/system.nix defaults):
  #
  # Choose kernel series:
  #   boot.kernelPackages = pkgs.linuxPackages_latest;   # default
  #   boot.kernelPackages = pkgs.linuxPackages_lts;
  #   boot.kernelPackages = pkgs.linuxPackages_hardened;
  #   boot.kernelPackages = pkgs.linuxPackages_zen;
  #
  # Extra kernel parameters (boot-time):
  #   boot.kernelParams = [
  #     "quiet"
  #     "loglevel=3"
  #   ];
  #
  # Extra kernel modules from the chosen kernelPackages set:
  #   boot.extraModulePackages = [
  #     pkgs.linuxPackages_lts.v4l2loopback
  #   ];

  # Example secret mapping guarded by file existence (non-breaking placeholder)
  sops.secrets."example-password" = lib.mkIf (builtins.pathExists ../../secrets/example.yaml) {
    sopsFile = ../../secrets/example.yaml;
  };
  # Usage example:
  # services.postgresql = {
  #   enable = true;
  #   # passwordFile will be provided by sops-nix at build time
  #   authentication = {
  #     passwordFile = config.sops.secrets."example-password".path;
  #   };
  # };
}
