{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./ghostty.nix
    ./spicetify.nix
    # ./cursors.nix
  ];

  home.packages = with pkgs; [
    bibata-cursors
    papirus-icon-theme

    gtk3
    gtk-layer-shell
    gtk4
    gtk4-layer-shell

    krabby
    fortune
    pokemonsay
    tmux
    thundery

    vesktop
    onlyoffice-bin
    teams-for-linux
    zoom-us
    xfce.ristretto
    obsidian
    sticky-notes
    inputs.zen-browser.packages.${system}.twilight
    MtgDesktopCompanion

    ferium
    portablemc
    prismlauncher
    cataclysm-dda
    brogue-ce
    openttd
    forge-mtg
    cockatrice
    xmage
  ];

  # dconf.settings."org/gnome/desktop/interface".icon-theme = "Papirus";
  # gtk.iconTheme = {
  #   package = pkgs.papirus-icon-theme;
  #   name = "Papirus";
  # };

  programs.git = {
    enable = true;
    userName = "JPierro0513";
    userEmail = "jmpierro0513@gmail.com";
    extraConfig = {
      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
    };
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base24-schemes}/share/themes/chalk.yaml";
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
    fonts = {
      serif = {
        # package = pkgs.source-serif-pro;
        name = "Monaspace Xenon";
        package = pkgs.monaspace;
      };
      sansSerif = {
        # package = pkgs.rubik;
        name = "Monaspace Argon";
        package = pkgs.monaspace;
      };
      monospace = {
        package = pkgs.monaspace;
        name = "Monaspace Neon";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
