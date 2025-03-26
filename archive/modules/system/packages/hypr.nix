{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    hypridle
    hyprpaper
    hyprlock
    swaynotificationcenter
    hyprpolkitagent
    wl-clipboard
    cliphist
    grimblast
    brightnessctl
    playerctl

    gtk3
    gtk4
    gtk4-layer-shell
    amdvlk

    inputs.walker.packages.${pkgs.system}.default
  ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    # withUWSM = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
