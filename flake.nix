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
    inherit (outputs) nixpkgs home-manager nixos-cosmic;

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
          {
            nix = let
              flakeInputs = nixpkgs.lib.filterAttrs (_: nixpkgs.lib.isType "flake") inputs;
            in {
              extraOptions = ''download-buffer-size = 500000000'';
              settings = {
                auto-optimise-store = true;
                experimental-features = ["nix-command" "flakes"];
                flake-registry = "";
                nix-path = nixpkgs.config.nix.nixPath;
                substituters = [
                  "https://nix-community.cachix.org"
                  "https://chaotic-nyx.cachix.org"
                  "https://cosmic.cachix.org/"
                  # "https://hyprland.cachix.org"
                ];
                trusted-public-keys = [
                  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                  "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
                  "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
                  # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                ];
              };
              channel.enable = false;
              registry = nixpkgs.lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
              nixPath = nixpkgs.lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
            };
          }

          home-manager.nixosModules.home-manager
          nixos-cosmic.nixosModules.nixos-cosmic

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
