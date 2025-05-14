{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nsearch.url = "github:niksingh710/nsearch";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [./system ./home];
      perSystem = {
        self',
        pkgs,
        inputs',
        system,
        ...
      }: {
        formatter = pkgs.alejandra;

        checks =
          inputs'.nixpkgs.lib.attrsets.unionOfDisjoint {
            git-hooks = inputs.git-hooks.lib.${system}.run {
              hooks = {
                deadnix.enable = true;
                alejandra.enable = true;
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
