{
  pkgs,
  config,
  ...
}: let
  conf = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  imports = [
    ./niri
  ];

  home.packages = with pkgs; [
    fd
    ripgrep
    killall
    viu
    lazygit
    nitch

    # misc
    libnotify
    fontconfig
    alejandra
    deadnix
    statix
    netscanner

    inputs.nsearch.packages.${pkgs.system}.default
    krabby
    fortune
    pokemonsay
    tmux
    thundery

    # desktop
    vesktop
    onlyoffice-bin
    inputs.zen-browser.packages.${system}.twilight
    zed-editor
    meld
    kdePackages.kpmcore
    kdePackages.partitionmanager
    teams-for-linux
    zoom-us
    xfce.ristretto
    obsidian
    MtgDesktopCompanion

    # games
    ferium
    portablemc
    prismlauncher
    cataclysm-dda
    brogue-ce
    openttd
    forge-mtg
    cockatrice

    # gnome
    dconf-editor
    pwvucontrol
    resources
    gnome-control-center
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
      # theme = "camellia-hope";
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

  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
    settings = {
      use-agent = true;
      # default-key = "481EFFCF2C7B8C7B";
    };
  };
}
