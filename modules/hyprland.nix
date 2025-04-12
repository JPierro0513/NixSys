{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    hyprlock
    hypridle
    hyprpaper
    hyprpanel
    hyprpolkitagent
    swaynotificationcenter
    kando
    brightnessctl
    playerctl
    rofi-wayland
    cliphist
    wl-clipboard
    power-profiles-daemon
    wf-recorder
    hyprpicker
    hyprsunset
    matugen
    inputs.anyrun.packages.${system}.anyrun-with-all-plugins
    nwg-dock-hyprland
  ];
}
