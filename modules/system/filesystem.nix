{
  # fileSystems."/" = {
  #   device = "none";
  #   fsType = "tmpfs";
  #   options = ["defaults" "size=50%" "mode=755"];
  # };
  # fileSystems."/persist" = {
  #   device = "/dev/disk/by-uuid/a64f15bb-720f-440c-a11e-ddd04a30931f";
  #   fsType = "btrfs";
  #   neededForBoot = true;
  #   options = ["subvol=@/persist"];
  # };
  # fileSystems."/nix" = {
  #   device = "/dev/disk/by-uuid/a64f15bb-720f-440c-a11e-ddd04a30931f";
  #   fsType = "btrfs";
  #   neededForBoot = true;
  #   options = ["subvol=@/nix"];
  # };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A8D5-BA39";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/a64f15bb-720f-440c-a11e-ddd04a30931f";
    fsType = "btrfs";
    neededForBoot = true;
    options = ["subvol=@"];
  };

  swapDevices = [];
}
