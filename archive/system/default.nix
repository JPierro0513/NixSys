{
  self,
  inputs,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    specialArgs = {inherit inputs self;};
  in {
    nixos = nixosSystem {
      inherit specialArgs;
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./core
        ./nix
        ./hardware
        ./services
        ./programs

        {
          home-manager = {
            users.jpierro.imports =
              homeImports."jpierro@nixos";
            extraSpecialArgs = specialArgs;
          };
        }

        inputs.chaotic.nixosModules.default
      ];
    };
  };
}
