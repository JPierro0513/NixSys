{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri

    # ./settings.nix
    # ./binds.nix
    # ./rules.nix

    ./hyprlock.nix
    ./wlogout.nix
  ];

  home = {
    packages = with pkgs; [
      seatd
      niri

      # screenshot
      grim
      slurp

      # utils
      wl-clipboard
      cliphist

      swaynotificationcenter
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
