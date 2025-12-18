{...}: {
  # Fuzzy finder
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border"
      "--inline-info"
    ];
    colors = {
      "bg+" = "#3c3836";
      "fg+" = "#ebdbb2";
      "hl" = "#83a598";
      "hl+" = "#83a598";
    };
  };
}
