{
  pkgs,
  lib,
  ...
}: let
  # Add new packages here.
  # Keep this file as the single obvious place to extend your user environment.
  fonts = [
    # Fonts (Ghostty config expects this font family)
    pkgs."nerd-fonts"."jetbrains-mono"
  ];

  cli = with pkgs; [
    # Modern replacements for common commands
    eza # Modern replacement for ls
    bat # Modern replacement for cat
    ripgrep # Modern replacement for grep (rg)
    fd # Modern replacement for find
    fzf # Fuzzy finder
    zoxide # Smart directory jumper (z command)

    # Additional useful tools
    htop # Process monitor
    btop # Process monitor (TUI)
    tree # Directory tree viewer
    wget # File downloader
    curl # HTTP client
    jq # JSON processor

    # System utilities
    fastfetch # System info (fast)
    zip # Archive tool
    unzip # Archive tool

    # Nix + direnv integration
    nix-direnv
  ];

  notifications = with pkgs; [
    libnotify # provides notify-send
    swaynotificationcenter # swaync + swaync-client
  ];

  desktop = with pkgs; [
    hyprlock
    hyprpaper

    # Overlay tools / launchers
    wofi

    # Desktop apps referenced by Hyprland config / session defaults
    vivaldi
    vivaldi-ffmpeg-codecs
    widevine-cdm
    kdePackages.dolphin
    slack

    # Hyprland keybind dependencies
    brightnessctl
    playerctl

    # Wayland clipboard + portals (screen sharing / file pickers)
    wl-clipboard
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk

    # Polkit agent (autostarted by Hyprland)
    lxqt.lxqt-policykit

    # Remote Desktop
    anydesk
  ];

  dev = with pkgs; [
    git # Version control
    gh # GitHub CLI
    delta # Git diff pager

    # Terminals
    ghostty
    warp-terminal
    kitty

    # Shell/dev workflow
    tmux
    zellij
    just
    yazi

    # Language/tooling
    nodejs
    python312
    python312Packages.pip
    python312Packages.virtualenv
    python312Packages.setuptools

    luarocks
    lua-language-server

    nodePackages.prettier
    nodePackages.eslint_d

    yq-go
  ];

  cloud = with pkgs; [
    awscli2
    google-cloud-sdk
    azure-cli
  ];

  k8s = with pkgs; [
    # Kubernetes/Helm tooling
    kubectl
    kubernetes-helm
    k9s
    kubectx
    kustomize
    stern

    # K8s/platform ops tooling
    argocd
    flux
    cilium-cli
    kubelogin-oidc
    talosctl
  ];

  warpWayland = pkgs.writeShellScriptBin "warp-wayland" ''
    #!/usr/bin/env bash
    set -euo pipefail

    # Prefer Wayland for Warp (winit)
    export WINIT_UNIX_BACKEND=wayland

    # Also help other toolkits if Warp spawns anything (harmless if unused)
    export QT_QPA_PLATFORM=wayland
    export GDK_BACKEND=wayland
    export ELECTRON_OZONE_PLATFORM_HINT=wayland

    exec warp-terminal "$@"
  '';

  matlabXwayland = pkgs.writeShellScriptBin "matlab-xwayland" ''
    #!/usr/bin/env bash
    set -euo pipefail

    # Force X11/XWayland backends for MATLAB/Simulink under Hyprland.
    # Your Hyprland session sets Wayland-preference env globally; this wrapper overrides it.
    export QT_QPA_PLATFORM=xcb
    export GDK_BACKEND=x11
    export CLUTTER_BACKEND=x11

    # Java/AWT hint for wlroots compositors / non-reparenting WMs
    export _JAVA_AWT_WM_NONREPARENTING=1

    # Prevent toolkits from auto-selecting Wayland
    unset WAYLAND_DISPLAY

    # Resolve the MATLAB binary.
    # 1) User override via env var
    MATLAB_CMD="''${MATLAB_CMD:-}"

    # 2) Common /opt install locations (MathWorks default)
    if [ -z "$MATLAB_CMD" ]; then
      for c in \
        /opt/MATLAB/R2025b/bin/matlab \
        /opt/MATLAB/R2025a/bin/matlab \
        /opt/MATLAB/R2024b/bin/matlab \
        /opt/MATLAB/R2024a/bin/matlab
      do
        if [ -x "$c" ]; then
          MATLAB_CMD="$c"
          break
        fi
      done
    fi

    # 3) Fall back to PATH
    if [ -z "$MATLAB_CMD" ] && command -v matlab >/dev/null 2>&1; then
      MATLAB_CMD="matlab"
    fi

    if [ -z "$MATLAB_CMD" ]; then
      echo "[matlab-xwayland] ERROR: MATLAB binary not found." >&2
      echo "[matlab-xwayland] Set MATLAB_CMD=/opt/MATLAB/R2025b/bin/matlab (or adjust the wrapper)." >&2
      exit 127
    fi

    exec "$MATLAB_CMD" "$@"
  '';

  all = fonts ++ cli ++ notifications ++ desktop ++ dev ++ cloud ++ k8s ++ [warpWayland matlabXwayland];
in {
  # Ensure user-installed fonts are discoverable
  fonts.fontconfig.enable = true;

  home.packages = lib.lists.unique all;
}
