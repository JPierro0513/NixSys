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
    wget
    curl
    git
    github-cli
    unzip
    kdePackages.ark
    sqlite
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
    glib
  ];

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
