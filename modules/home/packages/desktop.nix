{pkgs, ...}: {
  home.packages = with pkgs; [
    vesktop
    onlyoffice-bin
    teams-for-linux
    inputs.zen-browser.packages.${pkgs.system}.twilight
    gnome-calendar
    adobe-reader
    gimp
    ristretto
    obsidian
    zed-editor
    neovide
  ];
}
