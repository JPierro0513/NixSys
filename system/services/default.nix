{
  imports = [./bluetooth.nix ./power.nix];

  services.xserver.xkb.layout = "us";
  services.printing.enable = true;
  services.libinput.enable = true;
  services.openssh.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };
}
