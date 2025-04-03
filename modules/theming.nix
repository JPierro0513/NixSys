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
    settings."org/gnome/desktop/interface".icon-theme = "Numix";
    settings."org/gnome/desktop/interface".cursor-theme = "Bibata-Modern-Classic";
    settings."org/gnome/desktop/interface".cursor-size = 16;
    settings."org/gnome/desktop/interface".theme = "Juno";
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.juno-theme;
      name = "Juno";
    };
    iconTheme = {
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
