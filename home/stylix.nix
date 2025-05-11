{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    polarity = "dark";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus";
      light = "Papirus";
    };
    image = null;
    fonts = {
      serif = {
        package = pkgs.source-serif-pro;
        name = "Source Serif Pro";
      };
      sansSerif = {
        package = pkgs.rubik;
        name = "Rubik";
      };
      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
