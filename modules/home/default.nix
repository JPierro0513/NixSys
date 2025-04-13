{pkgs, ...}: {
  imports = [
    ./ghostty.nix
    ./spicetify.nix
    ./cursors.nix
  ];

  home.packages = with pkgs; [
    bibata-cursors
    papirus-icon-theme

    gtk3
    gtk-layer-shell
    gtk4
    gtk4-layer-shell

    krabby
    fortune
    pokemonsay
    tmux
    thundery

    vesktop
    onlyoffice-bin
    teams-for-linux
    zoom-us
    xfce.ristretto
    obsidian
    sticky-notes
    inputs.zen-browser.packages.${system}.twilight
    MtgDesktopCompanion

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

  programs.git = {
    enable = true;
    userName = "JPierro0513";
    userEmail = "jmpierro0513@gmail.com";
    extraConfig = {
      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
    };
  };
}
