{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nsearch.url = "github:niksingh710/nsearch";
    tabby.url = "github:ChocolateLoverRaj/tabby/nix";
  };
  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./system
        # ./home
      ];
      systems = ["x86_64-linux"];
      perSystem = {
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        formatter = pkgs.alejandra;

        packages = import ./pkgs pkgs;

        checks =
          inputs'.nixpkgs.lib.attrsets.unionOfDisjoint {
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
          self'.packages.${system};
      };
    };
}
