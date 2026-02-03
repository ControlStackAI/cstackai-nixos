{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    bcc

    # Keep container daemon tooling system-scoped
    docker

    # Keep virtualization system-scoped (libvirt/qemu live in modules/core/virtualisation.nix)
    virt-manager
  ];
}
