{...}: {
  # Enhanced directory navigation and environment management
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Better file manager integration (if using a file manager)
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
