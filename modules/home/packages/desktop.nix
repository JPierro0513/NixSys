{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    vesktop
    onlyoffice-bin
    teams-for-linux
    inputs.zen-browser.packages.${pkgs.system}.twilight
    gnome-calendar
    zathura
    gimp
    xfce.ristretto
    obsidian

    qt6ct

    sticky
    sticky-notes
  ];

  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 16;
      window-padding-x = 5;
      window-padding-y = 5;
      cursor-style = "bar";
      cursor-style-blink = true;
      mouse-hide-while-typing = true;
    };
  };
}
