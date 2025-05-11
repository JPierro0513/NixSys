{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri

    ./binds.nix
  ];

  programs.niri = let
    makeCommand = command: {
      command = [command];
    };
  in {
    enable = true;
    settings = {
      spawn-at-startup = [
        (makeCommand "swww-daemon")
        # (makeCommand "swww img ~/wallpapers/nixos.png")
        (makeCommand "wl-paste --watch cliphist store")
        (makeCommand "${pkgs.waybar}/bin/waybar")
        (makeCommand "xwayland-satellite")
        (makeCommand "albert")
      ];
      environment = {
        DISPLAY = ":0";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
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
      # hotkey-overlay.skip-at-startup = true;
    };
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    seatd
    grimblast
    wl-clipboard
    cliphist
    brightnessctl
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
