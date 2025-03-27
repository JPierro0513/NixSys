{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    # ./power.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # avahi required for service discovery
  services.avahi.enable = true;

  services.openssh.enable = true;

  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  # };

  #maybe ollama
}
