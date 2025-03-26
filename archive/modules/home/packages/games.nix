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
    freedroidrpg
    nzportable
    forge-mtg
    cockatrice
    xmage
  ];
}
