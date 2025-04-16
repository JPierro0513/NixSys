{
  inputs,
  pkgs,
  config,
  ...
}: let
  conf = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  imports = [
    ./bat.nix
    ./git.nix
    ./gpg.nix
    ./skim.nix
    ./yazi.nix
    ./ghostty.nix

    ./niri
  ];

  # nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar
    kdePackages.ark

    # misc
    libnotify
    fontconfig
    alejandra
    deadnix
    statix
    netscanner

    # term
    wget
    curl
    btop
    lazygit
    fastfetch
    eza
    fd
    ripgrep
    killall
    viu
    fzf
    zoxide
    inputs.nsearch.packages.${pkgs.system}.default
    krabby
    fortune
    pokemonsay
    tmux
    thundery

    # langs
    nodejs
    nodePackages.npm
    vscode-langservers-extracted
    lua
    lua-language-server
    nil
    nixd
    rustup
    python313
    python313Packages.pip

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

  home.sessionVariables = {
    # clean up ~
    LESSHISTFILE = "${cache}/less/history";
    LESSKEY = "${conf}/less/lesskey";
    XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";
    DIRENV_LOG_FORMAT = "";
  };

  programs = {
    ssh.enable = true;
    dircolors = {
      enable = true;
    };
  };
}
