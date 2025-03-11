{
  pkgs,
  inputs,
  lib,
  ...
}: {
  
  imports =
    [ ./modules/packages.nix
      ./modules/shell.nix
      ./modules/hyprland.nix
      ./modules/theming.nix
    ];
  
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    username = "jpierro";
    homeDirectory = "/home/jpierro";
  };
}
