{
  pkgs,
  swayfx,
  ...
}: {
  environment.systemPackages = with pkgs; [
    grimblast
    wl-clipboard
    swaynotificationcenter
    brightnessctl
    playerctl
    rofi-wayland
  ];

  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    package = swayfx.packages.${pkgs.system}.default;
  };

  programs.light.enable = true;

  # kanshi systemd service
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };

  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];
}
