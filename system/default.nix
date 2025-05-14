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
        ./services
        ./programs

        {
          services.displayManager = {
            # sessionPackages = "${pkgs.niri}/bin/niri-session";
            sddm = {
              enable = true;
              wayland.enable = true;
            };
          };
        }

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users.jpierro.imports = [
              {
                home = {
                  username = "jpierro";
                  homeDirectory = "/home/jpierro";
                  stateVersion = "25.05";
                };
                programs.home-manager.enable = true;
              }

	      ./home/services
              ./home/programs
              ./home/stylix.nix
            ];
          };
        }
      ];
    };
  };
}
