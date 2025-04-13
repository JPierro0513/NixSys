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
    kitty-img
    kitty
    hyprlock
    hypridle
    hyprpaper
    hyprpolkitagent
    hyprsunset
    pyprland
    swaynotificationcenter
    onagre
    brightnessctl
    playerctl
    # rofi-wayland
    cliphist
    wl-clipboard
    power-profiles-daemon
    wf-recorder
    # waybar
    ironbar
    qt5-wayland
    qt6-wayland
  ];
}
