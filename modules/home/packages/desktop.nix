{
  pkgs,
  zen-browser,
  ...
}: {

  home.packages = with pkgs; [
    vesktop
    onlyoffice-bin
    teams-for-linux
    zathura
    xfce.ristretto
    obsidian

    sticky-notes

    zen-browser.packages.${pkgs.system}.twilight
  ];
}
