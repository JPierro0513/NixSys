{
  pkgs,
  inputs,
  ...
}: {
  imports = [./thunar.nix];

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    gh

    unzip
    gzip
    kdePackages.ark

    kdePackages.kpmcore
    kdePackages.partitionmanager

    btop
    nitch
    killall
    inputs.nsearch.packages.${pkgs.system}.default
    meld

    eza
    bat
    fd
    ripgrep
    fzf
    zoxide
    thefuck
    yazi
    viu
    imagemagick

    libgcc
    libclang
    nodejs
    nodePackages.npm
    python3
    python3Packages.pip
    rustup
    nixd
    nil
    alejandra
    lua-language-server
    vscode-langservers-extracted
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    defaultEditor = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libusb1
    ];
  };

  programs = {
    gamemode.enable = true;
    gamescope.enable = true;
    steam = {
      enable = true;
      # remotePlay.openFirewall = true;
      # dedicatedServer.openFirewall = true;
    };
  };
}
