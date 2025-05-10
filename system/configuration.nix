{pkgs, ...}: {
  # Set your time zone.
  time.timeZone = "America/New_York";
  services.geoclue2.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {LC_ALL = "en_US.UTF-8";};

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
