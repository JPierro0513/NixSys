_: {
  imports = [
    ./gnome-services.nix
    ./pipewire.nix
    ./power.nix
    ./greetd.nix
  ];

  services = {
    printing.enable = true;

    dbus.implementation = "broker";

    # profile-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };

  # Use in place of hypridle's before_sleep_cmd, since systemd does not wait for it to complete
  powerManagement = {
    enable = true;
    powerDownCommands = ''
      # Lock all sessions
      loginctl lock-sessions

      # Wait for lockscreen(s) to be up
      sleep 1
    '';
  };

  hardware.brillo.enable = true;
}
