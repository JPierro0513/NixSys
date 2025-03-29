{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./thunar.nix
    ./fish.nix
    ./hypr.nix
    ./swayfx.nix
    ./langs.nix
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      sdl3
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    github-cli

    unzip
    kdePackages.ark

    sqlite

    kdePackages.kpmcore
    kdePackages.partitionmanager

    qt6.qtdeclarative
    qt6ct

    htop
    lazygit
    fastfetch
    fd
    ripgrep
    bat
    eza
    fzf
    zoxide
    thefuck
    viu
    imagemagick
    yazi
    superfile
    inputs.nsearch.packages.${pkgs.system}.default

    zed-editor

    glib

    # (pkgs.callPackage ./thundery.nix)
  ];

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  services.flatpak.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
