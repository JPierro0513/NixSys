{
  pkgs,
  inputs,
  # lib,
  ...
}: {
  imports = [inputs.stylix.homeManagerModules.stylix];

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
    # fonts = {
    #   serif = {
    #     # package = pkgs.source-serif-pro;
    #     name = "Monaspace Xenon";
    #     package = pkgs.monaspace;
    #   };
    #   sansSerif = {
    #     # package = pkgs.rubik;
    #     name = "Monaspace Argon";
    #     package = pkgs.monaspace;
    #   };
    #   monospace = {
    #     package = pkgs.monaspace;
    #     name = "Monaspace Neon";
    #   };
    #   emoji = {
    #     package = pkgs.noto-fonts-emoji;
    #     name = "Noto Color Emoji";
    #   };
    # };
  };
}
