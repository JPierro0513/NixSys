{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./thunar.nix
  ];

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    gh

    unzip
    kdePackages.ark

    kdePackages.kpmcore
    kdePackages.partitionmanager

    btop
    nitch
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
    killall
    viu
    imagemagick

    libgcc
    clang
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

  # programs.gpg = {
  #   enable = true;
  #   homedir = "${config.xdg.dataHome}/gnupg";
  #   settings = {
  #     use-agent = true;
  #   };
  # };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libusb1
    ];
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 15;
      };
    };
  };
  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  fonts = {
    packages = with pkgs; [
      corefonts
      maple-mono.NF
      source-serif-pro
      rubik
    ];
    fontconfig = {
      defaultFonts = {
        monospace = ["Maple Mono NF"];
        sansSerif = ["Rubik"];
        serif = ["Source Serif Pro"];
        # emoji = ["Noto Color Emoji"];
      };
    };
  };
}
