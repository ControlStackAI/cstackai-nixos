{
  # Declarative layout for HP Firefly 16 G11 (single 1TB NVMe)
  # Root filesystem is bcachefs, /boot is a small EFI vfat partition.
  #
  # If your NVMe device name differs from /dev/nvme0n1, adjust `device` below
  # before running disko on new hardware.
  disko.devices = {
    disk = {
      nvme0n1 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
              size = "512MiB";
              type = "ef00"; # EFI System Partition
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["fmask=0077" "dmask=0077"];
              };
            };

            root = {
              name = "root";
              size = "100%";
              content = {
                type = "filesystem";
                format = "bcachefs";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
