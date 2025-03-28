{pkgs, ...}: {
  home.packages = with pkgs; [
    ferium
    portablemc
    prismlauncher
    luanti
    cataclysm-dda
    brogue-ce
    openttd
    nzportable
    forge-mtg
    cockatrice
    xmage
  ];
}
