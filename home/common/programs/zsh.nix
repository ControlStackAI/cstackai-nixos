{...}: {
  # User-level tooling and shell configs
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Warp's zsh integration may reference $INSIDE_EMACS in title/prompt hooks.
    # When zsh's UNSET behavior is enabled, referencing an unset variable throws
    # "parameter not set" errors. This guard preserves INSIDE_EMACS when defined
    # (e.g. inside Emacs) and otherwise defaults it to empty.
    envExtra = ''
      export INSIDE_EMACS=''${INSIDE_EMACS-}
    '';

    # Shell aliases for better experience
    shellAliases = {
      ll = "eza -la --icons";
      ls = "eza --icons";
      cat = "bat";
      grep = "rg";
      find = "fd";
      tree = "eza --tree --icons";
    };

    # Additional zsh configuration
    initContent = ''
      # Load completions early
      autoload -U compinit && compinit

      # Better history settings
      setopt EXTENDED_HISTORY
      setopt SHARE_HISTORY
      setopt APPEND_HISTORY
      setopt INC_APPEND_HISTORY
      setopt HIST_EXPIRE_DUPS_FIRST
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_FIND_NO_DUPS
      setopt HIST_IGNORE_SPACE
      setopt HIST_SAVE_NO_DUPS
      setopt HIST_REDUCE_BLANKS
      setopt HIST_VERIFY

      # Better completion
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu select

      # Fuzzy finding keybindings
      bindkey '^R' fzf-history-widget
      bindkey '^T' fzf-file-widget
      bindkey '^[c' fzf-cd-widget

      # Warp Auto-Warpify hook (persist the snippet Warp suggests)
      # Paste the Warp-provided auto-warpify snippet here so it persists across rebuilds.
      # After you successfully Warpify this host from your client, copy the
      # snippet Warp shows and place it below. Example placeholder only:
      # [ -n "$WARP_IS_REMOTE" ] && true
    '';
  };
}
