{pkgs, ...}: {
  imports = [
    ./hypr.nix
    ./thunar.nix
    ./langs.nix
    ./terminal.nix
    ./fish.nix
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      SDL
      SDL2
      ncurses
      alsa-lib
      libxkbcommon
      wayland
      libvulkan
      xorg.libxcb
      # required by livekit:
      libGL
      xorg.libX11
      xorg.libXext
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
    kdePackages.qtdeclarative

    kdePackages.kpmcore
    kdePackages.partitionmanager

    # zed-editor

    power-profiles-daemon
    gammastep

    esbuild

    sqlite
  ];

  programs = {
    light.enable = true;
    dconf.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    gamescope.enable = true;
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
