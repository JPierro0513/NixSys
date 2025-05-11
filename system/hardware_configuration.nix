{
  pkgs,
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "usbhid" "rtsx_pci_sdmmc"];
      kernelModules = [];
      systemd.enable = true;
    };
    kernelModules = ["kvm-amd" "amdgpu"];
    kernelParams = [
      "amd_pstate=active"
      "amd_iommu"
      "nvme_core.default_ps_max_latency_us=0"
      "quiet"
    ];
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;
      "kernel.nmi_watchdog" = 0;
    };
    plymouth.enable = true;
    tmp.cleanOnBoot = true;
    loader = {
      # limine.enable = true;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/efb4b66b-3c70-4563-b704-ca18457d2108";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A8D5-BA39";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # useDHCP = true;
  };

  hardware = {
    graphics = {
      enable = true;
      # package = inputs.niri.packages.${pkgs.system}.mesa;
      enable32Bit = true;
      # package32 = inputs.niri.packages.${pkgs.system}.mesa32;
      extraPackages = with pkgs; [mesa glxinfo rocmPackages.clr.icd];
    };
    amdgpu.amdvlk.enable = true;
  };
}
