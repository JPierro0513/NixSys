{
  description = "NixOS configuration for my personal computer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    walker.url = "github:abenz1267/walker";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";
    astal.url = "github:aylur/astal";
    astal.inputs.nixpkgs.follows = "nixpkgs";

    nsearch = {
      url = "github:niksingh710/nsearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    impermanence,
    neovim-nightly-overlay,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
      overlays = [
        neovim-nightly-overlay.overlays.default
      ];
    };
  in {
    formatter = pkgs.alejandra;

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {inherit self inputs;};
      modules = [
        {
          nix = {
            extraOptions = ''download-buffer-size = 500000000'';
            settings = {
              auto-optimise-store = true;
              extraOptions = [
                "experimental-features = nix-command flakes"
              ];
              substituters = [
                "https://hyprland.cachix.org"
                "https://nix-community.cachix.org"
                "https://chaotic-nyx.cachix.org"
                "https://walker.cachix.org"
              ];
              trusted-public-keys = [
                "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
                "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
              ];
            };
          };
        }

        ./configuration.nix
        ./home.nix
      ];
    };
  };
}
