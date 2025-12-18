{config, ...}: {
  # Override the desktop entry so launchers (wofi) use the wrapper
  xdg.desktopEntries."dev.warp.Warp" = {
    name = "Warp";
    exec = "warp-wayland %U";
    icon = "dev.warp.Warp";
    terminal = false;
    categories = ["System" "TerminalEmulator"];
  };

  # Set Vivaldi as the default browser/handler for web links and HTML
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = ["vivaldi-stable.desktop"];
      "x-scheme-handler/http" = ["vivaldi-stable.desktop"];
      "x-scheme-handler/https" = ["vivaldi-stable.desktop"];
      # optional but helpful
      "x-scheme-handler/about" = ["vivaldi-stable.desktop"];
      "x-scheme-handler/unknown" = ["vivaldi-stable.desktop"];
    };
  };

  # Home Manager writes this file via the xdg.mimeApps module. Force overwrite so a pre-existing
  # mimeapps.list (often created by desktop environments or previous tooling) doesn't block activation.
  xdg.dataFile."applications/mimeapps.list".force = true;

  # Standardize XDG user directories and ensure they exist
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${config.home.homeDirectory}/Desktop";
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = "${config.home.homeDirectory}/Music";
    pictures = "${config.home.homeDirectory}/Pictures";
    publicShare = "${config.home.homeDirectory}/Public";
    templates = "${config.home.homeDirectory}/Templates";
    videos = "${config.home.homeDirectory}/Videos";
  };
}
