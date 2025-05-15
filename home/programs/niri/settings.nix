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
        #X11 server
        (makeCommand "xwayland-satellite")
        # Wallpaper
        (makeCommand "swww-daemon")
        {command = ["swww" "img" "/home/jpierro/wallpapers/waves.png"];}

        (makeCommand "${pkgs.waybar}/bin/waybar")
        (makeCommand "albert")

        # Utilities
        {command = ["nm-applet" "--indicator"];}
        (makeCommand "blueman-applet")
        (makeCommand "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1")
        {command = ["wl-paste" "--watch" "cliphist" "store"];}

        {command = ["systemctl" "--user" "import-environment"];}
        {command = ["hash" "dbus-update-activation-environment" "2>/dev/null"];}
        {command = ["dbus-update-activation-environment" "--systemd"];}
      ];
      environment = {
        DISPLAY = ":0";
        GDK_BACKEND = "wayland,x11";
        QT_QPA_PLATFORM = "wayland;xcb";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
      };
      input = {
        keyboard.xkb.layout = "us";
        mouse.accel-speed = 0.2;
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus = true;
        workspace-auto-back-and-forth = true;
      };
      screenshot-path = "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png";
      layout = {
        # focus-ring = {
        #   enable = true;
        #   width = 3;
        #   active.color = "#82dcccff";
        #   inactive.color = "#798bb2ff";
        # };
        # border.enable = false;
        focus-ring.enable = false;
        border = {
          enable = true;
          width = 3;
          active.color = "#7fb4ca";
          inactive.color = "#090e13";
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
        preset-column-widths = [
          {proportion = 0.25;}
          {proportion = 0.5;}
          {proportion = 0.75;}
          {proportion = 1.0;}
        ];
        default-column-width = {};
        gaps = 8;
        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };
        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "left";
          corner-radius = 20.0;
          gap = -12.0;
          gaps-between-tabs = 10.0;
          width = 4.0;
          length.total-proportion = 0.1;
        };
      };
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
    };
  };
}
