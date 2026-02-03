{...}: {
  # Manage Ghostty terminal config via Home Manager module
  programs.ghostty = {
    enable = true;
    settings = {
      "font-family" = "JetBrainsMono Nerd Font";
      "font-size" = 12;
      theme = "Gruvbox Dark Hard";
      "copy-on-select" = true;
    };
  };
}
