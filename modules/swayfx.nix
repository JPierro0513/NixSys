{
  pkgs,
  inputs,
  system,
  ...
}: {
  environment.systemPackages = with pkgs; [
    grimblast
    wl-clipboard
    swaynotificationcenter
    brightnessctl
    playerctl
    rofi-wayland
    waybar
  ];

  programs = {
    sway = {
      enable = true;
      package = inputs.swayfx.packages.${system}.swayfx-unwrapped;
      wrapperFeatures.gtk = true;
      extraSessionCommands = ''
        export XDG_SESSION_TYPE=wayland
        export XDG_CURRENT_SESSION=sway
        export DESKTOP_SESSION=sway
        export LIBSEAT_BACKEND=logind
        export QT_QPA_PLATFORM="wayland;xcb"
        export GDK_DPI_SCALE=1
        export QT_SCALE_FACTOR=1
        export QT_AUTO_SCREEN_SCALE_FACTOR=0
        export QT_QPA_PLATFORMTHEME=qt6ct
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
    };
  };
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  programs.light.enable = true;

  xdg = {
    portal = {
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
      ];
    };
  };
}
