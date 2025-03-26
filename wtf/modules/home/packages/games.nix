{pkgs, ...}: {
  home.packages = with pkgs; [
    ferium
    portablemc
    prismlauncher
    luanti
    cataclysm-dda
    brogue-ce
    openttd
    openrw
    openjk
    meritous
    opendune
    nzportable
    forge-mtg
    cockatrice
    xmage
  ];
}
