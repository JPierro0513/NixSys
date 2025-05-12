{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
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
    home-manager,
    neovim-nightly-overlay,
    niri,
    stylix,
    ...
  }: let
    inherit (self) inputs outputs;
    specialArgs = {inherit inputs outputs;};
    forEachSystem = nixpkgs.lib.genAttrs ["x86_64-linux"];
    pkgs = forEachSystem (system:
      import nixpkgs {
        inherit system;
        config = {allowUnfree = true;};
        overlays = [
          neovim-nightly-overlay.overlays.default
          niri.overlays.default
          (final: _prev: import ./packages final.pkgs)
          (final: prev: {})
        ];
      });
  in {
    formatter = pkgs.alejandra;

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = specialArgs;
      modules = [
        ./system

        home-manager.nixosModules.default
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.jpierro = {
              home = {
                username = "jpierro";
                homeDirectory = "/home/jpierro";
                stateVersion = "25.05";
              };
              programs.home-manager.enable = true;
              systemd.user.startService = "sd-switch";
            };
            modules = [./home];
            backupFileExtension = "bak";
            extraSpecialArgs = specialArgs;
          };
        }
        stylix.nixosModules.default
      ];
    };
  };
}
