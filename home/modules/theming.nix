{ pkgs, ...}:
{
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
      # package = pkgs.flat-remix-gtk;
      # name = "Flat-Remix-GTK-Grey-Darkest";
      package = pkgs.juno-theme;
      name = "Juno";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      # package = pkgs.gnome.adwaita-icon-theme;
      # name = "Adwaita";
      name = "Papirus";
    };
    font = {
      name = "Source Sans Pro";
      size = 12;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}