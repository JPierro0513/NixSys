{pkgs, ...}: {
  imports = [./bluetooth.nix ./power.nix];

  services.printing.enable = true;
  services.avahi.enable = true;
  services.openssh.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };
  environment.systemPackages = with pkgs; [pavucontrol];

  services = {
    scx.enable = true;
    scx.scheduler = "scx_rusty";
  };

  services = {
    dbus = {
      implementation = "broker";
      packages = with pkgs; [
        gcr
        gnome-settings-daemon
      ];
    };
    gnome.gnome-keyring.enable = true;
  };

  services.displayManager.cosmic-greeter.enable = true;

  security.pam.services.hyprlock = {};
}
