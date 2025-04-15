{pkgs, ...}: {
  users.users.jpierro = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      # "adbusers"
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "transmission"
      "video"
      "wheel"
      "audio"
      "dialout"
    ];
  };
}
