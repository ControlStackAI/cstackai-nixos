{
  config,
  pkgs,
  ...
}: {
  # Intentionally empty: user-facing tools/apps are managed via Home Manager
  # for parity between NixOS and Ubuntu + Home Manager.
  environment.systemPackages = with pkgs; [];
}
