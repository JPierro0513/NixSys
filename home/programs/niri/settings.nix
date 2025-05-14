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
        {command = ["swww" "img" "$HOME/wallpapers/waves.png"];}

        (makeCommand "${pkgs.waybar}/bin/waybar")
        (makeCommand "albert")

        # Utilities
        {command = ["nm-applet" "--indicator"];}
        (makeCommand "blueman-applet")
        (makeCommand "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1")
        {command = ["wl-paste" "--watch" "cliphist" "store"];}

        # (makeCommand "systemctl" "--user" "import-environment")
        # (makeCommand "hash" "dbus-update-activation-environment" "2>/dev/null")
        # (makeCommand "dbus-update-activation-environment" "--systemd")
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
        gaps = 6;
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
          width = 1;
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
      animations.shaders.window-resize = ''
        vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
          vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;

          vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
          vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;

          // We can crop if the current window size is smaller than the next window
          // size. One way to tell is by comparing to 1.0 the X and Y scaling
          // coefficients in the current-to-next transformation matrix.
          bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
          bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;

          vec3 coords = coords_stretch;
          if (can_crop_by_x)
              coords.x = coords_crop.x;
          if (can_crop_by_y)
              coords.y = coords_crop.y;

          vec4 color = texture2D(niri_tex_next, coords.st);

          // However, when we crop, we also want to crop out anything outside the
          // current geometry. This is because the area of the shader is unspecified
          // and usually bigger than the current geometry, so if we don't fill pixels
          // outside with transparency, the texture will leak out.
          //
          // When stretching, this is not an issue because the area outside will
          // correspond to client-side decoration shadows, which are already supposed
          // to be outside.
          if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))
              color = vec4(0.0);
          if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))
              color = vec4(0.0);

          return color;
        }
      '';
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
    };
  };
}
