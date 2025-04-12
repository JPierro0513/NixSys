{
  pkgs,
  inputs,
  system,
  ...
}: {
  home.packages = with pkgs; [
    # Theming
    juno-theme
    bibata-cursors
    numix-icon-theme
    gtk3
    gtk-layer-shell
    gtk4
    gtk4-layer-shell
    # Terminal apps
    krabby
    fortune
    pokemonsay
    tmux
    thundery
    # Desktop apps
    vesktop
    onlyoffice-bin
    teams-for-linux
    xfce.ristretto
    obsidian
    sticky-notes
    inputs.zen-browser.packages.${system}.twilight
    MtgDesktopCompanion
    zoom-us
    # Games
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

  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 18;
      window-padding-x = 5;
      window-padding-y = 5;
      cursor-style = "bar";
      cursor-style-blink = true;
      mouse-hide-while-typing = true;
      theme = "camellia-hope";
    };
    themes = {
      camellia-hope = {
        background = "#17181C";
        cursor-color = "#E4E5E7";
        foreground = "#E4E5E7";
        palette = [
          "0=#17181C"
          "1=#FA3867"
          "2=#3FD43B"
          "3=#FEBD16"
          "4=#53ADE1"
          "5=#AD60FF"
          "6=#47E7CE"
          "7=#B0B1B4"
          "8=#26272B"
          "9=#FA3867"
          "10=#3FD43B"
          "11=#FEBD16"
          "12=#53ADE1"
          "13=#AD60FF"
          "14=#47E7CE"
          "15=#E4E5E7"
        ];
        selection-background = "#353749";
        selection-foreground = "#cdd6f4";
      };
    };
  };

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

  # Install Spicetify (Spotify)
  imports = [inputs.spicetify-nix.homeManagerModules.default];
  programs.spicetify = let
    spicepkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    enabledExtensions = with spicepkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
    enabledCustomApps = with spicepkgs.apps; [
      newReleases
      ncsVisualizer
    ];
    enabledSnippets = with spicepkgs.snippets; [
      rotatingCoverart
      pointer
    ];
    theme = spicepkgs.themes.hazy;
  };
}
