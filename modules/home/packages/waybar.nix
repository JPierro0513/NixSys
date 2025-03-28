{pkgs, ...}:
{
  home.packages = with pkgs; [
    waybar
  ];
  
  xdg = {
    enable = true;
    configFile."waybar/config" = {
      enable = true;
      text = builtins.toJSON {
        modules-center = ["sway/workspaces"];
        modules-left = [
          "clock"
          "mpris"
          "sway/window"
          "sway/mode"
        ];
        modules-right = [
          "tray"
          "temperature"
          "memory"
          "cpu"
          "pulseaudio"
          "backlight"
          "bluetooth"
          "network"
          "battery"
        ];
      }; #waybarConfig.waybarConfig;
    };
  };
}