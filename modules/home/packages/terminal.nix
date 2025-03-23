{pkgs, ...}: {
  home.packages = with pkgs; [
    pokete
    krabby
    pokeget-rs
    fortune
    pokemonsay

    tmux
  ];
}
