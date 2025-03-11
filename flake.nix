{
  description = "My system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, ... } @ inputs: 
  let
    inherit (self) outputs;
    
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
  in
  {
    formatter = pkgs.alejandra;

    # overlays = import ./overlays { inherit inputs; };

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
	      modules =
	        [ ./nixos/configuration.nix
	          inputs.home-manager.nixosModules.home-manager
	          inputs.impermanence.nixosModules.impermanence
	          {
                    home-manager = {
	              useGlobalPkgs = true;
		      useUserPackages = true;
		      backupFileExtension = "bak";
		      extraSpecialArgs = { inherit pkgs inputs outputs; };
		      users.jpierro = import ./home;
	           };
	         }
               ];
      };
    };
  };
}
