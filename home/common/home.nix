{...}: {
  imports = [
    ./packages.nix
    ./desktop.nix
    ./services.nix
    ./session.nix
    ./xdg.nix
    ./secrets.nix

    ./hm-compat.nix

    ./programs/zsh.nix
    ./programs/starship.nix
    ./programs/fzf.nix
    ./programs/shell-tools.nix
    ./programs/git.nix
    ./programs/ssh.nix
    ./programs/ghostty.nix
    ./programs/neovim.nix

    ./dev/k8s.nix
    ./dev/git-repos.nix
  ];

  # Let Home Manager install/manage itself (useful for standalone HM on non-NixOS)
  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
