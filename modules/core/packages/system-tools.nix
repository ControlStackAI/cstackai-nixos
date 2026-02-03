{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    bolt
    minicom
    tftp-hpa

    # omnictl  # Temporarily disabled due to network timeouts
    # ceph  # Temporarily disabled due to build issue in unstable
  ];
}
