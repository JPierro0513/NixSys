{pkgs, ...}: {
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk.iconTheme = {
    package = pkgs.numix-icon-theme;
    name = "Numix";
  };
  gtk.cursorTheme = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
  };

  # gtk = {
  #   enable = true;
  #   theme = {
  #     package = pkgs.nordic;
  #     name = "Nordic-darker";
  #   };
  #   iconTheme = {
  #     package = pkgs.numix-icon-theme;
  #     name = "Numix";
  #   };
  #   cursorTheme = {
  #     package = pkgs.bibata-cursors;
  #     name = "Bibata-Modern-Classic";
  #   };
  #   font = {
  #     name = "Rubik";
  #     size = 14;
  #   };
  # };

  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk3";
  # };
}
