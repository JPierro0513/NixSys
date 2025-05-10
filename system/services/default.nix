{pkgs, lib, ...}: {
  imports = [
    ./bluetooth.nix
    ./power.nix
    ./greetd.nix
  ];

  security.rtkit.enable = true;
  environment.systemPackages = with pkgs; [pavucontrol];

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };
    fstrim.enable = true;
    scx.enable = true;
    scx.scheduler = "scx_rusty";
    printing.enable = true;
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
    dbus = {
      implementation = "broker";
      packages = with pkgs; [
        gcr
        gnome-settings-daemon
      ];
    };
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
  };

  powerManagement = {
    enable = true;
    powerDownCommands = ''
      # Lock all sessions
      loginctl lock-sessions

      # Wait for lockscreen(s) to be up
      sleep 1
    '';
  };

  services.avahi.enable = true;
  services.openssh.enable = true;
}
