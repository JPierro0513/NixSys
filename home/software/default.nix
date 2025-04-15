{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./anyrun
    ./browsers/zen.nix
    ./stylix.nix
  ];

  home.packages = with pkgs; [
    # messaging
    vesktop

    # misc
    colord
    ffmpegthumbnailer
    imagemagick
    cliphist
    nodejs
    nodePackages.npm

    fastfetch
    netscanner

    # gnome
    dconf-editor
    amberol
    loupe
    pwvucontrol
    resources
    gnome-control-center

    swww
    inputs.ghostty.packages.${pkgs.system}.default

    onlyoffice-bin
    teams-for-linux
    zoom-us

    obsidian
    sticky-notes

    ferium
    portablemc
    prismlauncher
    cataclysm-dda
    brogue-ce
    openttd
    forge-mtg
    cockatrice
    xmage
  ];
}
