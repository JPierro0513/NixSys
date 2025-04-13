{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";

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

    nixvim = {
      url = "github:nix-community/nixvim";
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

    devShells.${system} = {
      esp-idf = import ./shells/esp-idf.nix {};
    };

    checks =
      nixpkgs.lib.attrsets.unionOfDisjoint {
        git-hooks = inputs.git-hooks.lib.${system}.run {
          hooks = {
            deadnix.enable = true;
            editorconfig-checker.enable = true;
            hlint.enable = true;
            alejandra = {
              enable = true;
              settings.width = 120;
            };
            statix.enable = true;
            typos.enable = true;
          };
          src = ./.;
        };
        maintainers-sorted = (import ./stylix/check-maintainers-sorted.nix) pkgs;
      }
      self.packages.${system};

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {inherit inputs outputs system;};
      modules = [
        # Nix settings
        {
          nix = let
            flakeInputs = nixpkgs.lib.filterAttrs (_: nixpkgs.lib.isType "flake") inputs;
          in {
            extraOptions = ''download-buffer-size = 500000000'';
            channel.enable = false;
            registry = nixpkgs.lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
            nixPath = nixpkgs.lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
            settings = {
              auto-optimise-store = true;
              experimental-features = ["nix-command" "flakes"];
              flake-registry = "";
              # nix-path = config.nix.nixPath;
              substituters = [
                "https://nix-community.cachix.org"
                "https://chaotic-nyx.cachix.org"
                "https://hyprland.cachix.org"
              ];
              trusted-public-keys = [
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
                "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
              ];
            };
          };
        }
        # NixOS modules
        inputs.home-manager.nixosModules.home-manager
        # inputs.stylix.nixosModules.stylix
        inputs.nixvim.nixosModules.nixvim
        # Custom modules
        ./configuration.nix
        ./hardware-configuration.nix
        ./modules/services
        ./modules/system
        # Home configuration
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            extraSpecialArgs = {inherit inputs outputs pkgs system;};
            users.jpierro = {
              imports = [
                inputs.stylix.homeManagerModules.stylix
                # Home modules
                ./modules/home
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
}
