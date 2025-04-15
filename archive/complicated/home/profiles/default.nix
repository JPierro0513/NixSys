{
  self,
  inputs,
  ...
}: let
  # get these into the module system
  extraSpecialArgs = {inherit inputs self;};

  homeImports = {
    "jpierro@nixos" = [
      ../.
      ./nixos
    ];
  };

  inherit (inputs.hm.lib) homeManagerConfiguration;

  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfiguration = {
      "jpierro_nixos" = homeManagerConfiguration {
        modules = homeImports."jpierro@nixos";
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}
