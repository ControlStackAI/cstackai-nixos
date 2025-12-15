{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../common/home.nix
  ];

  home.username = "matthew-mangano";
  home.homeDirectory = "/home/matthew-mangano";

  # This machine currently has ~/.ssh/id_jzUbuntu(.pub)
  my.sshKeys = {
    githubKey = "${config.home.homeDirectory}/.ssh/id_jzUbuntu";
    githubKeyPub = "${config.home.homeDirectory}/.ssh/id_jzUbuntu.pub";
    # Use the same key for GitLab unless you add a dedicated one.
    gitlabKey = "${config.home.homeDirectory}/.ssh/id_jzUbuntu";
  };
}
