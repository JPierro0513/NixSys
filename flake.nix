{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

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
    home-manager,
    nixos-cosmic,
    ...
  }: let
    inherit (self) outputs;
    inherit (inputs) nixpkgs home-manager nixos-cosmic;

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

          home-manager.nixosModules.home-manager
          nixos-cosmic.nixosModules.default

          ./hardware-configuration.nix
          ./configuration.nix
          ./modules/fish.nix
          ./modules/services.nix
          ./modules/system.nix
          ./modules/thunar.nix

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
