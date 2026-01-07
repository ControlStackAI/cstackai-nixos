{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./core/locale.nix
    ./core/users.nix
    ./core/packages.nix
    ./core/programs.nix
    ./core/services.nix
    ./core/security.nix
    ./core/system.nix
    ./core/sound.nix
    ./core/fonts.nix
    ./core/neovim.nix
    ./core/virtualisation.nix
    ./core/git-repo-manager.nix
    ./core/screenshots.nix
    ./core/ai-tools.nix

    # NixOS-only desktop tools (Warp, Deskflow, etc.)
    ./core/desktop-tools.nix
  ];

  # Override warp-terminal to a specific upstream build.
  # To update:
  #   1) Run:  just update-warp <new-version>
  #   2) Paste the printed version/url/hash block into this overlay.
  nixpkgs.overlays = [
    (final: prev: {
      warp-terminal = prev.warp-terminal.overrideAttrs (old: {
        version = "0.2025.12.17.17.17.stable_02";
        src = prev.fetchurl {
          url = "https://releases.warp.dev/stable/v0.2025.12.17.17.17.stable_02/warp-terminal-v0.2025.12.17.17.17.stable_02-1-x86_64.pkg.tar.zst";
          hash = "sha256-VGNIXVhrVu9Kqtg09E9MPPjvX87tNT6E7Ls6/+JkhO0=";
        };
      });
    })
  ];
}
