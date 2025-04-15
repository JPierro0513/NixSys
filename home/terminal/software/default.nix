{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./cli.nix
    ./git.nix
    ./gpg.nix
    ./skim.nix
    ./yazi.nix
    ./xdg.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [alejandra deadnix statix self.packages.${pkgs.system}.repl];
}
