{pkgs, ...}: {
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-black";
    };
    iconTheme = {
      # package = pkgs.papirus-icon-theme;
      # name = "Papirus";
      package = pkgs.numix-icon-theme;
      name = "Numix";
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
    platformTheme.name = "gtk3";
  };
}
