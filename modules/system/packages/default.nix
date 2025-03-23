{pkgs, ...}: {
  imports = [
    ./hypr.nix
    ./thunar.nix
    ./langs.nix
    ./terminal.nix
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    git

    unzip
    kdePackages.ark

    sqlite
    kdePackages.qtdeclarative

    kdePackages.kpmcore
    kdePackages.partitionmanager

    zed-editor

    power-power-profiles-daemon
    gammastep

    esbuild
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
      enableSteamRuntime = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
