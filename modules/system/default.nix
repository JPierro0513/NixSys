{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./thunar.nix
    ./fish.nix
    # ./fonts.nix
    ./sddm.nix
    ./hyprland.nix
    ./nixvim
  ];

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    github-cli

    unzip
    kdePackages.ark
    kdePackages.kpmcore
    kdePackages.partitionmanager

    btop
    lazygit
    yazi
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
    inputs.nsearch.packages.${pkgs.system}.default
    zed-editor
    meld

    steam
    steamcmd
    steam-tui

    gnumake
    clang
    python3
    python3Packages.pip
    # python3Packages.pynvim
    sqlite
    nodejs
    rustup
    lua
    lua-language-server
    nil
    nixd
    alejandra
    openjdk21
    hyprls
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.ollama.enable = true;

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  stylix = {
    enable = true;
    base16Scheme = lib.mkDefault "${pkgs.base24-schemes}/share/themes/chalk.yaml";
    polarity = "dark";
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
