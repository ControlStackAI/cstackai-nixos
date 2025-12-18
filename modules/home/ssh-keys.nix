{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  homeDir = config.home.homeDirectory;
in {
  options.my.sshKeys = {
    githubKey = mkOption {
      type = types.str;
      default = "${homeDir}/.ssh/github_id";
      description = "SSH private key path to use for github.com (identityFile).";
    };

    gitlabKey = mkOption {
      type = types.str;
      default = "${homeDir}/.ssh/glab";
      description = "SSH private key path to use for gitlab.com (identityFile).";
    };

    githubKeyPub = mkOption {
      type = types.str;
      default = "${homeDir}/.ssh/github_id.pub";
      description = "SSH public key path used for git commit signing (gpg.format=ssh) and allowed_signers generation.";
    };
  };
}
