{
  # config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "us";
    useXkbConfig = true; # use xkb.options in tty.
  };
  services.xserver.xkb.layout = "us";

  hardware = {
    graphics = {
      enable = true;
      # package = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa.drivers;
      enable32Bit = true;
      # package32 = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.pkgsi686Linux.mesa.drivers;
      extraPackages = with pkgs; [ mesa amdvlk glxinfo rocmPackages.clr.icd ];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.fish;
    users.jpierro = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "audio" "video" "udev"];
    };
  };
  environment.localBinInPath = true;
  services.getty.autologinUser = "jpierro";

  system.stateVersion = "25.05"; # Did you read the comment?
}
