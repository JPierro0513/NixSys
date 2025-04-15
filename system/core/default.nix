{lib, ...}: {
  imports = [
    ./users.nix
    ../nix
    ../programs/fish.nix
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
    # extraLocaleSettings = {
    #   LC_ADDRESS = "es_AR.UTF-8";
    #   LC_IDENTIFICATION = "es_AR.UTF-8";
    #   LC_MEASUREMENT = "es_AR.UTF-8";
    #   LC_MONETARY = "es_AR.UTF-8";
    #   LC_NAME = "es_AR.UTF-8";
    #   LC_NUMERIC = "es_AR.UTF-8";
    #   LC_PAPER = "es_AR.UTF-8";
    #   LC_TELEPHONE = "es_AR.UTF-8";
    #   LC_TIME = "es_AR.UTF-8";
    # };
  };

  console.keyMap = "us";

  # don't touch this
  system.stateVersion = lib.mkDefault "25.05";

  time.timeZone = lib.mkDefault "America/New_York";
  time.hardwareClockInLocalTime = lib.mkDefault true;

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
}
