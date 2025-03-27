{pkgs, ...}:
let
  thundery = import ./thundery.nix;
in
{
  home.packages = with pkgs; [
    krabby
    fortune
    pokemonsay
    tmux

    thundery
  ];
}
