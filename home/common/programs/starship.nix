{...}: {
  # Starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$all$character";
      add_newline = false;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        style = "bold cyan";
      };

      git_branch = {
        symbol = "🌱 ";
        style = "bold purple";
      };

      git_status = {
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
        deleted = "x";
        style = "bold red";
      };

      nix_shell = {
        symbol = "❄️ ";
        style = "bold blue";
      };

      python = {
        symbol = "🐍 ";
        style = "bold yellow";
        detect_extensions = ["py" "pyc" "pyo" "pyd" "pyw" "pyi"];
        detect_files = ["requirements.txt" "setup.py" "pyproject.toml" "Pipfile" ".python-version" "tox.ini"];
        detect_folders = ["venv" ".venv" "env" ".env" "virtualenv"];
        format = "via [$symbol$pyenv_prefix($version) (\\($virtualenv\\)) ]($style)";
      };

      rust = {
        symbol = "🦀 ";
        style = "bold red";
      };

      nodejs = {
        symbol = "⬢ ";
        style = "bold green";
      };
    };
  };
}
