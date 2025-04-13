{
  pkgs,
  inputs,
  ...
}: {
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
    # Getters
    wget
    curl
    git
    github-cli
    # Archivers
    unzip
    kdePackages.ark
    kdePackages.kpmcore
    kdePackages.partitionmanager
    # Important programs
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
    glib
    steamcmd
    steam-tui
    # Languages
    gnumake
    clang
    python3
    python3Packages.pip
    python3Packages.pynvim
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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      monaspace
      roboto
      rubik
      source-serif-pro
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
      font-awesome
      material-design-icons
    ];
    fontconfig.defaultFonts = {
      monospace = ["Monaspace Radon"];
      sansSerif = ["Roboto"];
      serif = ["Rubik"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
