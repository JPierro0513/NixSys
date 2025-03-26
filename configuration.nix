{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    inputs.home-manager.nixosModules.home-manager
    # inputs.walker.nixosModules.walker

    ./modules/system/filesystem.nix
    ./modules/system/fonts.nix
    ./modules/system/services
    ./modules/system/packages
  ];

  # Use the systemd-boot EFI boot loader.
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "rtsx_pci_sdmmc"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # nixpkgs.config.allowUnfree = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking.hostName = "nixos";
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "qwerty";
  };
  console = {
    # font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [mesa glxinfo rocmPackages.clr.icd];
    };
    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users = {
    # mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    # users.root.hashedPasswordFile = "/persist/passwords/root";
    users.jpierro = {
      # hashedPasswordFile = "/persist/passwords/jpierro";
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "audio" "video"];
      shell = pkgs.fish; # enabled in its own module
    };
  };
  # programs.fuse.userAllowOther = true;
  environment.localBinInPath = true;

  system.stateVersion = "25.05";
}
