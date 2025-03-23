{pkgs, ...}: {
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.juno-theme;
      name = "Juno";
    };
    iconTheme = {
      # package = pkgs.papirus-icon-theme;
      # name = "Papirus";
      package = pkgs.morewaita-icon-theme;
      name = "Morewaita";
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };
    font = {
      name = "Rubik";
      size = 14;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk3";
    platformThemeName = "Adwaita";
  };
}
