{
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

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
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
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];
    };
  in {
    formatter = pkgs.alejandra;

    # packages = (import ./packages nixpkgs.legacyPackages.${system});

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          ./home.nix
        ];
      };
    };
  };
}
