{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    lix-unstable = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        lix.follows = "lix-unstable";
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nsearch = {
      url = "github:niksingh710/nsearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    lix-module,
    ...
  }: let
    inherit (self) outputs;

    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        outputs.overlays.additions
        outputs.overlays.modifications
      ];
    };
  in {
    formatter = pkgs.alejandra;

    overlays = import ./overlays {inherit inputs outputs;};

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = {inherit inputs outputs system;};
        modules = [
          ./modules/settings.nix

          lix-module.nixosModules.default
          inputs.home-manager.nixosModules.home-manager

          ./configuration.nix
          ./hardware-configuration.nix
          ./modules/system.nix
          ./modules/services.nix
          ./modules/fish.nix
          ./modules/thunar.nix
          ./modules/hyprland.nix

          {
            home-manager = {
              backupFileExtension = "bak";
              extraSpecialArgs = {inherit inputs outputs pkgs system;};
              users.jpierro = {
                imports = [
                  ./modules/home.nix
                  ./modules/theming.nix
                ];

                home = {
                  username = "jpierro";
                  homeDirectory = "/home/jpierro";
                };

                programs.home-manager.enable = true;
                home.stateVersion = "25.05";
              };
            };
          }
        ];
      };
    };
  };
}
