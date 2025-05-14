{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hyprlock.nix
    ./niri
  ];

  home.packages = with pkgs; [
    thundery

    vesktop
    onlyoffice-bin
    ladybird
    inputs.zen-browser.packages.${pkgs.system}.twilight
    zed-editor
    teams-for-linux
    zoom-us
    xfce.ristretto
    obsidian

    resources
    gnome-control-center
    dconf-editor
    amberol
    pwvucontrol

    prismlauncher
    cataclysm-dda
    openttd
    forge-mtg
    cockatrice
  ];

  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 18;
      window-padding-x = 5;
      window-padding-y = 5;
      cursor-style = "bar";
      cursor-style-blink = true;
      mouse-hide-while-typing = true;
    };
  };

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
