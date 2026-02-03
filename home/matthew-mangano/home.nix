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
}
