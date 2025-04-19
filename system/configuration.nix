{
  pkgs,
  config,
  ...
}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = ["amdgpu"];
    kernelParams = [
      "amd_pstate=active"
      "amd_iommu"
      "mitigations=off"
      "nvme_core.default_ps_max_latency_us=0"
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "plymouth.use-simpledrm"
    ];
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;
      "kernel.nmi_watchdog" = 0;
    };
    bootspec.enable = true;
    initrd.systemd.enable = true;
    plymouth.enable = true;
    tmp.cleanOnBoot = true;
  };
  environment.systemPackages = [config.boot.kernelPackages.cpupower];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  security.pam.services.hyprlock.text = "auth include login";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {LC_ALL = "en_US.UTF-8";};

  # Hardware GPU acceleration
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [mesa glxinfo rocmPackages.clr.icd];
    };
    amdgpu.amdvlk.enable = true;
  };

  # Define a user account.
  users.users.jpierro = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video" "input" "dialout"];
  };
  environment.localBinInPath = true;
  services.getty.autologinUser = "jpierro";

  system.stateVersion = "25.05"; # Did you read the comment?
}
