{pkgs, ...}:
{
  home.packages = with pkgs; [
    krabby
    fortune
    pokemonsay
    tmux
  ];
}
