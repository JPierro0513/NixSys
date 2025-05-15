{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    specialArgs = {inherit inputs self;};
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
        inputs.niri.overlays.niri
        (final: _prev: import "${self}/packages" final.pkgs)
      ];
    };
  in {
    nixos = nixosSystem {
      inherit pkgs specialArgs;
      modules = [
        inputs.home-manager.nixosModules.default
        inputs.stylix.nixosModules.stylix

        ./configuration.nix
        ./hardware-configuration.nix
        ./bluetooth.nix
        ./fonts.nix

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users.jpierro.imports = let
              mod = "${self}/home";
            in [
              {
                home = {
                  username = "jpierro";
                  homeDirectory = "/home/jpierro";
                  stateVersion = "25.05";
                };
                programs.home-manager.enable = true;
              }

              "${mod}/services"
              "${mod}/programs"
              "${mod}/stylix.nix"
            ];
          };
        }
      ];
    };
  };
}
