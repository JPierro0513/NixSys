{
  # config,
  pkgs,
  ...
}: let
  # pointer = config.home.pointerCursor;
  makeCommand = command: {
    command = [command];
  };
in {
  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      spawn-at-startup = [
        (makeCommand "swww-daemon")
        # (makeCommand "swww img ~/wallpapers/nixos.png")
        (makeCommand "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1")
        (makeCommand "wl-paste --watch cliphist store")
        (makeCommand "${pkgs.waybar}/bin/waybar")
        (makeCommand "xwayland-satellite")
        (makeCommand "albert")
        (makeCommand "nm-applet --indicator")
        (makeCommand "systemctl --user import-environment")
        (makeCommand "hash dbus-update-activation-environment 2>/dev/null")
        (makeCommand "dbus-update-activation-environment --systemd")
      ];
      environment = {
        DISPLAY = ":0";
        GDK_BACKEND = "wayland,x11";
        QT_QPA_PLATFORM = "wayland;xcb";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };
      input = {
        keyboard.xkb.layout = "us";
        mouse.accel-speed = 0.2;
        focus-follows-mouse.enable = true;
      };
      screenshot-path = "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png";
      layout = {
        gaps = 8;
        focus-ring = {
          enable = true;
          width = 3;
          active.color = "#82dcccff";
          inactive.color = "#798bb2ff";
        };
        shadow = {
          enable = true;
          softness = 20;
          spread = 5;
          offset = {
            x = 5;
            y = 5;
          };
          draw-behind-window = true;
          color = "#000000aa";
        };
        border.enable = false;
        preset-column-widths = [
          {proportion = 0.25;}
          {proportion = 0.5;}
          {proportion = 0.75;}
          {proportion = 1.0;}
        ];
        default-column-width = {};
      };
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
    };
  };
}
