{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./thunar.nix
    ./fish.nix
    ./portal.nix

    ./niri
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
    alejandra
    lua-language-server
    vscode-langservers-extracted

    vesktop
    onlyoffice-bin
    inputs.zen-browser.packages.${system}.twilight
    zed-editor
    teams-for-linux
    zoom-us
    xfce.ristretto
    obsidian

    prismlauncher
    cataclysm-dda
    openttd
    forge-mtg
    cockatrice

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
    enableCoreFonts = true;
    enableDefaultFonts = true;
    packages = with pkgs; [
      maple-mono-NF
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
