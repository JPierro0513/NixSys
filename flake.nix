{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nsearch.url = "github:niksingh710/nsearch";
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
        # inputs.niri.overlays.niri
        # custom packages
        (final: _prev: import ./overlays final.pkgs)
        # Any modifications to existing packages
        (final: prev: {})
      ];
    };
    specialArgs = {inherit (self) inputs outputs;};
  in {
    formatter = pkgs.alejandra;

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = specialArgs;
        modules = [
          ./system

          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jpierro = {
                home = {
                  stateVersion = "25.05";
                  username = "jpierro";
                  homeDirectory = "/home/jpierro";
                };
                imports = [
                  ./home/packages

                  ./home/stylix.nix
                ];
                programs.home-manager.enable = true;
                systemd.user.startServices = "sd-switch";
              };
              backupFileExtension = "bak";
              extraSpecialArgs = specialArgs;
            };
          }
        ];
      };
    };

    checks = {
      pre-commit-check = inputs.git-hooks-nix.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
          deadnix.enable = true;
          statix.enable = true;
        };
      };
    };
  };
}
