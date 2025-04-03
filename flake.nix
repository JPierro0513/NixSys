{
  description = "NixOS configuration for my personal computer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swayfx = {
      url = "github:willpower3309/swayfx";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    nsearch = {
      url = "github:niksingh710/nsearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    inherit (self) outputs;

    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    # pkgs = import nixpkgs {
    #   inherit system;
    #   config = {allowUnfree = true;};
    #   # overlays = import ./overlays {inherit inputs;};
    #   overlays = [
    #     inputs.neovim-nightly-overlay.overlays.default
    #     outputs.overlays.additions
    #     outputs.overlays.modifications
    #   ];
    # };
  in {
    formatter = pkgs.alejandra;

    packages.${system} = import ./pkgs nixpkgs.legacyPackages.${system};

    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      # inherit pkgs;
      specialArgs = {inherit inputs outputs;};
      modules = [
        inputs.home-manager.nixosModules.home-manager
        # inputs.nixos-cosmic.nixosModules.default
        ./modules/settings.nix
        ./modules/configuration.nix
        ./modules/home.nix
      ];
    };
  };
}
