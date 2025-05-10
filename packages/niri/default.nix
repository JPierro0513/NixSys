{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
  ];

  programs.niri = {
    enable = true;
  };

  # home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    seatd
    niri
    grimblast
    wl-clipboard
    cliphist
    brightnessctl
    pwvucontrol
    swaynotificationcenter
    hypridle
    hyprlock
    swww
    waybar
    xwayland-satellite
    albert
  ];
}
