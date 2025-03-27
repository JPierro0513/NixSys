{
  pkgs,
  inputs,
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

    inputs.zen-browser.packages.${pkgs.system}.twilight

    inputs.better-control.packages.${pkgs.system}.better-control
  ];
}
