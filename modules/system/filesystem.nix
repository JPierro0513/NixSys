{
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A8D5-BA39";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/efb4b66b-3c70-4563-b704-ca18457d2108";
    fsType = "ext4";
  };

  swapDevices = [];
}
