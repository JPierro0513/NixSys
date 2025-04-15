{
  self,
  inputs,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    mod = "${self}/system";
    inherit (import "${self}/system") laptop;
    specialArgs = {inherit inputs self;};
  in {
    nixos = nixosSystem {
      inherit specialArgs;
      modules =
        laptop
        ++ [
          ./nixos
          "${mod}/programs/gamemode.nix"
          "${mod}/services/gnome-services.nix"
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
