{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri

    ./settings.nix
    ./binds.nix
    ./rules.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  home.packages = with pkgs; [
    seatd
    niri
    grimblast
    wl-clipboard
    cliphist
    brillo
    playerctl
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
