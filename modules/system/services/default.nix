{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./power.nix
    ./display-manager.nix
    ./security.nix
  ];
  services.printing.enable = true;
  services.libinput.enable = true;
  services.openssh.enable = true;
  services.cups.enable = true;
}
