{
  config,
  lib,
  ...
}: {
  # Better Git integration
  programs.git = {
    enable = true;

    # New-style configuration API
    settings = {
      user = {
        name = "Matthew Mangano";
        email = "matthew.mangano@gmail.com";
      };

      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      fetch.prune = true;
      color.ui = "auto";
      diff.colorMoved = "zebra";

      # SSH commit signing (recommended)
      gpg.format = "ssh";
      user.signingkey = config.my.sshKeys.githubKeyPub;
      commit.gpgsign = true;
      gpg.ssh.allowedSignersFile = "${config.xdg.configHome}/git/allowed_signers";

      includeIf."gitdir:${config.home.homeDirectory}/GithubProjects/ManganoConsulting/".path = "${config.xdg.configHome}/git/work.gitconfig";
    };

    # Global gitignore patterns
    ignores = [
      ".DS_Store"
      "*.swp"
      "*.swo"
      "*~"
      "node_modules"
      "dist"
      "target"
      ".venv"
      ".direnv"
      ".env"
      ".idea"
      ".vscode"
    ];
  };

  # Configure delta using the dedicated module
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  # Placeholder for work-specific Git config; edit to set your work email.
  xdg.configFile."git/work.gitconfig".text = ''
    [user]
      email = matthew@mangano-consulting.com
  '';

  # Generate allowed_signers from your SSH public key; used for local verification
  home.activation.sshAllowedSigners = lib.hm.dag.entryAfter ["writeBoundary"] ''
    set -euo pipefail
    conf_dir="$HOME/.config/git"
    pub="${config.my.sshKeys.githubKeyPub}"
    file="$conf_dir/allowed_signers"
    mkdir -p "$conf_dir"

    if [ -f "$pub" ]; then
      key_type=$(cut -d' ' -f1 "$pub")
      key_data=$(cut -d' ' -f2 "$pub")
      key_comment=$(cut -d' ' -f3- "$pub" || true)
      {
        printf "matthew.mangano@gmail.com %s %s" "$key_type" "$key_data"
        [ -n "''${key_comment:-}" ] && printf " %s" "$key_comment"
        printf "\n"
        printf "matthew@mangano-consulting.com %s %s" "$key_type" "$key_data"
        [ -n "''${key_comment:-}" ] && printf " %s" "$key_comment"
        printf "\n"
      } > "$file"
      chmod 0644 "$file"
    else
      echo "[git-sign] Warning: $pub not found; skipping allowed_signers generation" >&2
    fi
  '';
}
