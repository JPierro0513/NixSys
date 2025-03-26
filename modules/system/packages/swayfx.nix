{ pkgs, ...}:
let
  tools = import ./tools.nix;
in {
  xdg.portal = {
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  environment.systemPackages =
    [ pkgs.pcmanfm-qt ]
    ++ tools.swayTools
    # ++ tools.configTools
    # ++ tools.guiFramework
    # ++ tools.desktopThemes
    # ++ tools.miscTools
    ;

  programs = {
    sway = {
      enable = true;
      package = pkgs.swayfx;
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
        export QT_IM_MODULE=fcitx
        export GTK_IM_MODULE=fcitx
        export _JAVA_AWT_WM_NONREPARENTING=1
        exec gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
      '';
    };
  };
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  programs.light.enable = true;
}


# {
#   pkgs,
#   inputs,
#   ...
# }: {
#   environment.systemPackages = with pkgs; [
#     grimblast
#     wl-clipboard
#     swaynotificationcenter
#     brightnessctl
#     playerctl
#     rofi-wayland
#   ];
#
#   services.gnome.gnome-keyring.enable = true;
#   security.polkit.enable = true;
#
#   programs.sway = {
#     enable = true;
#     wrapperFeatures.gtk = true;
#     package = inputs.swayfx.packages.${pkgs.system}.default;
#   };
#
#   programs.light.enable = true;
#
#   # kanshi systemd service
#   systemd.user.services.kanshi = {
#     description = "kanshi daemon";
#     serviceConfig = {
#       Type = "simple";
#       ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
#     };
#   };
#
#   security.pam.loginLimits = [
#     {
#       domain = "@users";
#       item = "rtprio";
#       type = "-";
#       value = 1;
#     }
#   ];
# }
