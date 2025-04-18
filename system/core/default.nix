{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./boot.nix
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # don't touch this
  system.stateVersion = lib.mkDefault "25.05";

  time.timeZone = lib.mkDefault "America/New_York";
  # time.hardwareClockInLocalTime = lib.mkDefault true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  security = {
    # allow wayland lockers to unlock the screen
    pam.services.hyprlock.text = "auth include login";
    # userland niceness
    rtkit.enable = true;
    # don't ask for password for wheel group
    sudo.wheelNeedsPassword = false;
  };

  users.users.jpierro = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "input"
      "audio"
      "video"
      "networkmanager"
      "dialout"
      # "adbusers"
      # "input"
      # "libvirtd"
      # "networkmanager"
      # "plugdev"
      # "transmission"
      # "video"
      # "wheel"
      # "audio"
      # "dialout"
    ];
  };
}
