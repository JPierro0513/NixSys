{pkgs, ...}: {
  imports = [
    ./stylix.nix

    ./programs/fish.nix
    ./programs/niri
  ];

  home.packages = with pkgs; [
    vesktop
    onlyoffice-bin
    inputs.zen-browser.packages.${pkgs.system}.twilight
    zed-editor
    teams-for-linux
    zoom-us
    xfce.ristretto
    obsidian

    prismlauncher
    cataclysm-dda
    openttd
    forge-mtg
    cockatrice

    resources
    gnome-control-center
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

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit.Description = "polkit-gnome-authentication-agent-1";
    Install = {
      WantedBy = ["graphical-session.target"];
      Wants = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
