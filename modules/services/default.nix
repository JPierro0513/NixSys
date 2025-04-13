{pkgs, ...}: {
  imports = [
    ./power.nix
    ./bluetooth.nix
  ];

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };
  environment.systemPackages = with pkgs; [pavucontrol];

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable openssh
  services.openssh.enable = true;
}
