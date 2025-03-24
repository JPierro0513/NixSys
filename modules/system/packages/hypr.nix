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
  ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.walker = {
    enable = true;
    # runAsService = true;
    config = {
      websearch.prefix = "?";
      switcher.prefix = "/";
    };
  };
}
