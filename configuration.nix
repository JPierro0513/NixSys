{
  inputs,
  lib,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  hardware = {
    graphics = {
      enable = true;
      package = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa;
      enable32Bit = true;
      package32 = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.pkgsi686Linux.mesa;
      extraPackages = with pkgs; [mesa glxinfo rocmPackages.clr.icd];
    };
    amdgpu.amdvlk.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jpierro = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video" "input" "udev"];
  };
  environment.localBinInPath = true;
  services.getty.autologinUser = "jpierro";

  system.stateVersion = "25.05"; # Did you read the comment?
}
