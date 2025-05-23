{lib, ...}: {
  programs.hyprlock = lib.mkForce {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        immediate_render = true;
        hide_cursor = false;
      };

      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 3;
          blur_size = 12;
          noise = "0.1";
          contrast = "1.3";
          brightness = "0.2";
          vibrancy = "0.5";
          vibrancy_darkness = "0.3";
        }
      ];

      input-field = [
        {
          monitor = "";

          size = "300, 50";
          valign = "center";
          position = "0%, 10%";

          outline_thickness = 1;

          font_color = "rgb(211, 213, 202)";
          outer_color = "rgba(29, 38, 33, 0.6)";
          inner_color = "rgba(15, 18, 15, 0.1)";
          check_color = "rgba(141, 186, 100, 0.5)";
          fail_color = "rgba(229, 90, 79, 0.5)";

          placeholder_text = "Enter Password";

          dots_spacing = 0.2;
          dots_center = true;
          dots_fade_time = 100;

          shadow_color = "rgba(5, 7, 5, 0.1)";
          shadow_size = 7;
          shadow_passes = 2;
        }
      ];

      label = [
        {
          monitor = "";
          text = ''
            cmd[update:1000] echo "<span font-weight='light' >$(date +'%H %M %S')</span>"
          '';
          font_size = 300;
          font_family = "Monaspace Krypton";

          color = "rgb(8a9e6b)";

          position = "0%, 2%";

          valign = "center";
          halign = "center";

          shadow_color = "rgba(5, 7, 5, 0.1)";
          shadow_size = 20;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
      ];
    };
  };
}
