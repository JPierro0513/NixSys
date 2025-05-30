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
    ./hyprlock.nix
    ./wlogout.nix
  ];

  home = {
    packages = with pkgs; [
      seatd
      niri
      grim
      slurp
      wl-clipboard
      cliphist
      playerctl
      pwvucontrol
      brillo
      swaynotificationcenter
      waybar
      xwayland-satellite
      swww
      albert
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
