{config, ...}: {
  imports = [
    ../../../modules/home/git-repos.nix
  ];

  my.gitRepos = {
    enable = true;
    repos = import ../../repos.nix {homeDir = config.home.homeDirectory;};
  };
}
