{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    # General Window Rules
    windowrulev2 = [
      # Ignore maximize requests from most apps, but do NOT suppress it for MATLAB/Simulink
      # (Simulink in particular can mis-layout when it doesn't receive maximize/configure events).
      "suppressevent maximize, class:^(?!MATLAB|Matlab|Simulink).*$"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0" # Fix XWayland dragging issues

      # MATLAB / Simulink (XWayland)
      # NOTE: Change workspace "9" to wherever you want MATLAB pinned.
      "workspace 9 silent, xwayland:1, class:^(MATLAB|Matlab).*"
      "workspace 9 silent, xwayland:1, title:^(MATLAB).*$"
      "workspace 9 silent, xwayland:1, title:.*(Simulink).*"

      # Reduce flicker / resize artifacts on heavy XWayland apps
      "noanim, xwayland:1, class:^(MATLAB|Matlab|Simulink).*"
      "noblur, xwayland:1, class:^(MATLAB|Matlab|Simulink).*"
      "noshadow, xwayland:1, class:^(MATLAB|Matlab|Simulink).*"

      # Dialogs: float + center (helps when dialogs spawn behind)
      # Keep this scoped to MATLAB/Simulink so we don't affect other XWayland apps.
      "float, xwayland:1, class:^(MATLAB|Matlab|Simulink).*, title:.*(Preferences|Open|Save|Import|Export|Parameters|Properties).*"
      "center, xwayland:1, class:^(MATLAB|Matlab|Simulink).*, title:.*(Preferences|Open|Save|Import|Export|Parameters|Properties).*"

      # Example window rules (uncomment and modify as needed)
      # "float, class:^(kitty)$"
      # "float, title:^(File Manager)$"
      # "move 10 10, class:^(Firefox)$"
    ];

    # Workspace Rules (Uncomment and modify if needed)
    # workspace = [
    #   "w[tv1], gapsout:0, gapsin:0"
    #   "f[1], gapsout:0, gapsin:0"
    # ];

    # Assign applications to workspaces
    # "onworkspace:w[tv1], class:^(firefox)$"
    # "onworkspace:w[tv1], class:^(vlc)$"
    # "onworkspace:2, class:^(ghostty)$"
  };
}
