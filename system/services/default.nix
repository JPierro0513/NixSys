{pkgs, ...}: {
  imports = [
    ./bluetooth.nix
    ./power.nix
    ./location.nix
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  services = {
    dbus = {
      implementation = "broker";
      packages = with pkgs; [
        gcr
        gnome-settings-daemon
        libsecret
      ];
    };
    gnome.gnome-keyring.enable = true;
  };

  services = {
    # for SSD/NVME
    fstrim.enable = true;
    scx.enable = true;
    scx.scheduler = "scx_rusty";
  };

  services.printing.enable = true;
  services.openssh.enable = true;
  services.fwupd.enable = true;

  hardware.brillo.enable = true;
}
