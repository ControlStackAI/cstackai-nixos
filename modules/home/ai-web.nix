{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.ai-web;

  aiWebPkg = pkgs.buildNpmPackage {
    pname = "nymeria-ai-console";
    version = "1.0.0";
    src = ../../ai-web;

    npmDepsHash = "sha256-pPlnlNVSXCOXXhC9XgbGIxsEGNy1oyd/+buM47xSLlM=";
    dontNpmBuild = true;
  };

  aiWebWorkDir = "${aiWebPkg}/lib/node_modules/nymeria-ai-console";
  aiWebSrc =
    if cfg.sourceDir != null
    then cfg.sourceDir
    else aiWebWorkDir;
in {
  options.services.ai-web = {
    enable = mkEnableOption "ControlStackAI Web Console";
    port = mkOption {
      type = types.int;
      default = 3000;
      description = "Port to listen on";
    };
    sourceDir = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Optional working directory to run ai-web from (must contain server.js and node_modules). If null, a Nix-built package is used.";
    };
  };

  config = mkIf cfg.enable {
    # Install desktop entry
    xdg.desktopEntries.dev-workbench = {
      name = "ControlStackAI Workbench";
      comment = "AI-Native Development Console";
      exec = "vivaldi http://localhost:${toString cfg.port}";
      icon = "utilities-terminal";
      terminal = false;
      categories = ["Development"];
      settings = {
        Keywords = "ai;console;workbench;";
        StartupNotify = "true";
      };
    };

    systemd.user.services.ai-web = {
      Unit = {
        Description = "ControlStackAI Web Console";
        After = ["network.target"];
      };

      Service = {
        # Ensure 'ai' command is found in path
        # Point to the source files
        WorkingDirectory = aiWebSrc;
        Environment = [
          "PORT=${toString cfg.port}"
          "PATH=${config.home.profileDirectory}/bin:${pkgs.nodejs}/bin:/usr/bin:/bin"
        ];
        ExecStart = "${pkgs.nodejs}/bin/node server.js";
        Restart = "always";
      };

      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
}
