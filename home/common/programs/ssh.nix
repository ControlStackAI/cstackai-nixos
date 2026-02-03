{config, ...}: {
  imports = [
    ../../../modules/home/ssh-keys.nix
  ];

  # SSH managed declaratively
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = ["~/.ssh/config.d/*.conf"];
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = [config.my.sshKeys.githubKey];
      };
      "gitlab.com" = {
        hostname = "gitlab.com";
        user = "git";
        identityFile = [config.my.sshKeys.gitlabKey];
      };
      "*" = {};
    };
    extraConfig = ''
      AddKeysToAgent yes
      ServerAliveInterval 60
      ServerAliveCountMax 3
      ControlMaster auto
      ControlPath ~/.ssh/cm-%r@%h:%p
      ControlPersist 10m
    '';
  };

  # Ensure ~/.ssh/config.d exists (without committing secrets)
  home.file.".ssh/config.d/.keep".text = "";

  # Start OpenSSH agent for key caching
  services.ssh-agent.enable = true;
}
