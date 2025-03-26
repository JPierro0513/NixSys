{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./settings.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "default";

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
  users.users.jpierro = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video" "udev"];
    shell = pkgs.fish;
  };
  environment.localBinInPath = true;

  system.stateVersion = "25.05"; # Did you read the comment?
}
