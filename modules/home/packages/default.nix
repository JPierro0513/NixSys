# {pkgs, ...}:
{
  imports = [
    ./desktop.nix
    ./terminal.nix
    ./games.nix
    ./spicetify.nix
  ];

  # home.packages = with pkgs; [];
}
