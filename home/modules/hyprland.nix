{ pkgs, inputs, ...}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, F, exec, zen-twilight"
          "$mod, E, exec, footclient -e superfile"
          "$mod, Return, exec, footclient"
          "$mod, Space, exec, rofi -show drun"
          "$mod, M, exit"
          "$mod, Q, killactive"

          "$mod, K, togglespecialworkspace, magic"
          "$mod SHIFT, K, movetoworkspace, special:magic"

          "$mod Shift, S, exec, grimblast copy area"
          "$mod Ctrl,  S, exec, grimblast copy active"
          "$mod Alt,   S, exec, grimblast copy screen"
          ",       print, exec, grimblast copy screen"
        ]
        ++ (
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
    };
    extraConfig = ''
      monitor=eDP-1,highres,auto,1.333333

      exec = gsettings set org.gnome.desktop.interface gtk-theme "Juno"
      exec = gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

      exec-once = systemctl --user start hyprpolkitagent
      exec-once = nm-appplet --indicator &
      exec-once = waybar &
      exec-once = mako &
      exec-once = hyprpaper
      exec-once = foot --server

      env = XCURSOR_SIZE,24
      env = HYPRCURSOR_SIZE,24

      general {
       	gaps_in = 5
       	gaps_out = 5
      	border_size = 2
       	# col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
       	# col.inactive_border = rgba(595959aa)
        resize_on_border = true
        layout = dwindle
      }
  
      decoration {
        rounding = 10
        rounding_power = 2
        active_opacity = 1.0
        inactive_opacity = 1.0
        shadow {
          enabled = true
          range = 4
          render_power = 3
          color = rgba(1a1a1aee)
        }
        blur {
          enabled = true
          size = 3
          passes = 1
          vibrancy = 0.1696
        }
      }

      animations {
        enabled = yes, please :)
        bezier = easeOutQuint,0.23,1,0.32,1
        bezier = easeInOutCubic,0.65,0.05,0.36,1
        bezier = linear,0,0,1,1
        bezier = almostLinear,0.5,0.5,0.75,1.0
        bezier = quick,0.15,0,0.1,1
      	animation = global, 1, 10, default
      	animation = border, 1, 5.39, easeOutQuint
      	animation = windows, 1, 4.79, easeOutQuint
      	animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
      	animation = windowsOut, 1, 1.49, linear, popin 87%
      	animation = fadeIn, 1, 1.73, almostLinear
      	animation = fadeOut, 1, 1.46, almostLinear
      	animation = fade, 1, 3.03, quick
      	animation = layers, 1, 3.81, easeOutQuint
      	animation = layersIn, 1, 4, easeOutQuint, fade
      	animation = layersOut, 1, 1.5, linear, fade
      	animation = fadeLayersIn, 1, 1.79, almostLinear
      	animation = fadeLayersOut, 1, 1.39, almostLinear
      	animation = workspaces, 1, 1.94, almostLinear, fade
      	animation = workspacesIn, 1, 1.21, almostLinear, fade
      	animation = workspacesOut, 1, 1.94, almostLinear, fade
      }

      workspace = w[tv1], gapsout:0, gapsin:0

      dwindle {
        pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true # You probably want this
      }

      input {
        follow_mouse = true
        touchpad {
          natural_scroll = true
        }
      }

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mod, mouse_down, workspace, e+1
      bind = $mod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow

      # Laptop multimedia keys for volume and LCD brightness
      bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
      bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

      # Requires playerctl
      bindl = , XF86AudioNext, exec, playerctl next
      bindl = , XF86AudioPause, exec, playerctl play-pause
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous

      # Ignore maximize requests from apps. You'll probably like this.
      windowrulev2 = suppressevent maximize, class:.*

      # Fix some dragging issues with XWayland
      windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
    '';
  };
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
