{
  description = "NixOS configuration for my personal computer";

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

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    # walker.url = "github:abenz1267/walker";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    # ags.url = "github:aylur/ags";
    # ags.inputs.nixpkgs.follows = "nixpkgs";
    # astal.url = "github:aylur/astal";
    # astal.inputs.nixpkgs.follows = "nixpkgs";

    nsearch = {
      url = "github:niksingh710/nsearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    neovim-nightly-overlay,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
      overlays = [
        neovim-nightly-overlay.overlays.default
        (final: prev: {
          zed-editor = prev.zed-editor.overrideAttrs (oldAttrs: {
            postPatch =
              # Dynamically link WebRTC instead of static
              ''
                substituteInPlace $cargoDepsCopy/webrtc-sys-*/build.rs \
                --replace-fail "cargo:rustc-link-lib=static=webrtc" "cargo:rustc-link-lib=dylib=webrtc"
              ''
              # nixpkgs ships cargo-about 0.7, which is a seamless upgrade from 0.6
              + ''
                substituteInPlace script/generate-licenses \
                --replace-fail 'CARGO_ABOUT_VERSION="0.6"' 'CARGO_ABOUT_VERSION="0.7.1"'
              '';
          });
        })
      ];
    };
  in {
    formatter = pkgs.alejandra;

    packages = import ./packages nixpkgs.legacyPackages.${system};

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {inherit self inputs;};
      modules = [
        ./settings.nix
        ./configuration.nix
        ./home.nix
      ];
    };
  };
}
