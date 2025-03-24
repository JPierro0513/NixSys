{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./power.nix
    ./display-manager.nix
    ./security.nix
  ];

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.libinput.enable = true;
  services.openssh.enable = true;
}
