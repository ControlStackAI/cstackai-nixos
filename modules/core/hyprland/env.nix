{...}: {
  wayland.windowManager.hyprland.settings.env = [
    "XCURSOR_SIZE,24"
    "HYPRCURSOR_SIZE,24"

    # Force common toolkits to prefer Wayland
    "QT_QPA_PLATFORM,wayland"
    "GDK_BACKEND,wayland"
    "CLUTTER_BACKEND,wayland"

    # Font rendering tweaks
    "FREETYPE_PROPERTIES,truetype:interpreter-version=40"
    "QT_FONTCONFIG,1"

    # Force some apps to use Wayland (when possible)
    "ELECTRON_OZONE_PLATFORM_HINT,wayland"
    "MOZ_ENABLE_WAYLAND,1"

    # Warp uses winit on Linux; prefer Wayland backend
    "WINIT_UNIX_BACKEND,wayland"
  ];
}
