{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./thunar.nix
    ./fish.nix
    ./portal.nix
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
    meld

    steam
    steamcmd
    steam-tui

    clang
    nodejs
    nodePackages.npm
    python313
    python313Packages.pip
    rustup
    nixd
    nil
    alejandra
    lua
    lua-language-server
    vscode-langservers-extracted
  ];

  home-manager = {
    useUserPackages = true;
    backupFileExtension = "bak";
  };

  programs.dconf.enable = true;

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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
