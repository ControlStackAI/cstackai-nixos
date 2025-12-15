{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../common/home.nix
  ];

  home.username = "matthew";
  home.homeDirectory = "/home/matthew";
}
