{
  self,
  inputs,
  ...
}: let
  # get these into the module system
  extraSpecialArgs = {inherit inputs self;};

  homeImports = {
    "jpierro@nixos" = [
      ./services
      ./software
      ./stylix.nix

      {
        home = {
          username = "jpierro";
          homeDirectory = "/home/jpierro";
          stateVersion = "25.05";
        };

        # disable manuals as nmd fails to build often
        manual = {
          html.enable = false;
          json.enable = false;
          manpages.enable = false;
        };

        # let HM manage itself when in standalone mode
        programs.home-manager.enable = true;
      }
    ];
  };

  inherit (inputs.hm.lib) homeManagerConfiguration;

  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake.homeConfiguration = {
    "jpierro_nixos" = homeManagerConfiguration {
      modules = homeImports."jpierro@nixos";
      inherit pkgs extraSpecialArgs;
    };
  };
}
