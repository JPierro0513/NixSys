{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    lazygit
    htop
    grc
    github-cli
    fd
    ripgrep
    bat
    eza
    fzf
    zoxide
    thefuck
    fastfetch
    viu
    imagemagick
    yazi
    inputs.nsearch.packages.${pkgs.system}.default
  ];
}
