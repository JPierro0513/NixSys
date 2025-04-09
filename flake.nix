{
  description = "Simple NixOS configuration ... hopefully";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    swayfx = {
      url = "github:willpower3309/swayfx";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    nsearch = {
      url = "github:niksingh710/nsearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    # pkgs = import nixpkgs {
    #   inherit system;
    #   config = {
    #     allowUnfree = true;
    #   };
    #   overlays = [
    #     outputs.overlays.additions
    #     outputs.overlays.modifications
    #   ];
    # };
  in {
    formatter = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs system;};
        modules = [
          home-manager.nixosModules.home-manager

          ./hardware-configuration.nix
          ./configuration.nix
          ./modules/services.nix
          ./modules/system.nix
          ./modules/fish.nix
          ./modules/swayfx.nix
          ./modules/hyprland.nix
          ./modules/thunar.nix

          ./home.nix
          ./modules/waybar.nix
        ];
      };
    };
  };
}
