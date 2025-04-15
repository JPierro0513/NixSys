{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar

    # misc
    libnotify
    fontconfig

    # utils
    du-dust
    duf
    fd
    file
    jaq
    ripgrep
    killall
    koji
    jq

    tuicam
    fum

    inputs.nsearch.packages.${pkgs.system}.default
  ];

  programs = {
    eza.enable = true;
    ssh.enable = true;
    dircolors = {
      enable = true;
    };
  };
}
