{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    withUWSM = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  environment.systemPackages = with pkgs; [
    hypridle
    hyprlock
    hyprpaper
    hyprpolkitagent
    pyprland
    swaynotificationcenter
    wl-clipboard
    cliphist
    brightnessctl
    playerctl
    albert
    waybar
    inputs.swww.packages.${pkgs.system}.swww
    kitty
    kdePackages.xwaylandvideobridge
  ];
}
