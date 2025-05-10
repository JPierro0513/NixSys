{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
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
    specialArgs = {inherit self inputs;};
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
  in {
    formatter = pkgs.alejandra;

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = specialArgs;
      modules = [
        ./system
        ./services
        ./packages

        inputs.home-manager.nixosModules.default
        {
          home-manager = {
            # useGlobalPkgs = true;
            # useUserPackages = true;
            extraSpecialArgs = {inherit inputs pkgs;};
            users.jpierro = {
              imports = [
                ./packages/home.nix
              ];
              programs.home-manager.enable = true;
              systemd.user.startServices = "sd-switch";
              home = {
                stateVersion = "25.05";
                username = "jpierro";
                homeDirectory = "/home/jpierro";
              };
            };
          };
        }
      ];
    };
  };
}
