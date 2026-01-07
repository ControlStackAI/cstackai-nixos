{
  config,
  pkgs,
  ...
}: {
  # NixOS-only desktop GUI/dev tools.
  # These are installed system-wide so Ubuntu + standalone Home Manager
  # stay clean and only see the shared `home/common` layer.
  environment.systemPackages = with pkgs; [
    # Warp terminal (version pinned via the overlay in modules/common.nix)
    warp-terminal

    # Deskflow can be added here once it is packaged or overlaid in nixpkgs,
    # e.g. via an overlay similar to the warp-terminal one.
    # deskflow
  ];
}