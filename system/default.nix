{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    specialArgs = {inherit inputs self;};
  in {
    nixos = nixosSystem {
      inherit specialArgs;
      modules = [
        inputs.chaotic.nixosModules.default
        inputs.home-manager.nixosModules.default

        ./configuration.nix
        ./hardware-configuration.nix
        ./nix
        ./services
        ./packages

        {
          home-manager = {
            users.jpierro.imports = [
              ../home/services
              ../home/software
              ../home/stylix.nix
              {
                home = {
                  username = "jpierro";
                  homeDirectory = "/home/jpierro";
                  stateVersion = "25.05";
                };
                programs.home-manager.enable = true;
              }
            ];
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
