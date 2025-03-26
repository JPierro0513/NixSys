{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./thunar.nix
    ./fish.nix
    ./hypr.nix
    ./swayfx.nix
    ./langs.nix
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # programs.nix-ld = {
  #   enable = true;
  #   # libraries = with pkgs; [
  #   #   libpulseaudio
  #   # ];
  # };

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

    qt6.qtdeclarative
    qt6ct

    htop
    lazygit
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
    yazi
    superfile
    inputs.nsearch.packages.${pkgs.system}.default

    zed-editor
    # (cargo-about.overrideAttrs (drv: rec {
    #   name = "cargo-about";
    #   version = "0.6.6";
    #
    #   src = pkgs.fetchFromGitHub {
    #     owner = "EmbarkStudios";
    #     repo = "cargo-about";
    #     rev = version;
    #     sha256 = "sha256-6jza0IHdX7vyjZt1lknoVhlu7RONF5SnTdn7EDsj2oo=";
    #   };
    #
    #   # useFetchCargoVendor = true;
    #   # cargoHash = "";
    #
    #   cargoDeps = drv.cargoDeps.overrideAttrs (lib.const {
    #     name = "${name}";
    #     inherit src;
    #     outputHash = "";
    #   });
    # }))
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

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
}
