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
    # inputs.impermanence.nixosModules.impermanence
    inputs.walker.nixosModules.walker

    ./modules/system/filesystem.nix
    # ./modules/system/persist.nix
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
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking.hostName = "nixos";
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.xkb = {
    layout = "us";
    model = "pc104";
    variant = "qwerty";
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [mesa glxinfo rocmPackages.clr.icd];
    };
    # amdgpu.amdvlk.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  programs.nushell.enable = true;
  # programs.fish.enable = true;
  users = {
    # mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    # users.root.hashedPasswordFile = "/persist/passwords/root";
    users.jpierro = {
      # hashedPasswordFile = "/persist/passwords/jpierro";
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "audio" "video"];
      shell = pkgs.nushell;
    };
  };
  # programs.fuse.userAllowOther = true;
  environment.localBinInPath = true;

  system.stateVersion = "25.05";
}
