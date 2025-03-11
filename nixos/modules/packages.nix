{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    wget
    git
    curl
    htop
    zed-editor
    bash
    zsh
    gcc
    cmake
    clang
    gdb
    go
    cargo
    gjs
    nodejs
    lua
    python313
    python313Packages.pip
    python313Packages.pynvim
    nil
    nixd
    alejandra
    nix-diff
    hyprls
    lua-language-server
    bluez
    bluez-tools
    blueberry

    hyprland

    jq nox nix grc

    plymouth
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      sdl3
      sdl2-compat
      ncurses
    ];
  };

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    defaultEditor = true;
  };

  programs.dconf.enable = true;
  fonts = {
    packages = with pkgs;
      [ nerd-fonts.hack
        nerd-fonts.monaspace
        fira-sans
        source-sans-pro
        source-serif-pro
        noto-fonts
      ];
    fontconfig = {
      defaultFonts = {
        emoji = ["noto-fonts-emoji"];
        serif = ["Source Serif Pro"];
        sansSerif = ["Source Sans Pro"];
        monospace = ["Hack Nerd Font"];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
