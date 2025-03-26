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
    ...
  }: let
    inherit (self) outputs;

    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
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
    # forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    formatter = pkgs.alejandra;

    # packages = forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});

    # overlays = forAllSystems (system: import ./overlays {inherit inputs;});

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs outputs;};
      modules = [
        ./settings.nix
        ./configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs outputs;};
            backupFileExtension = "bak";
            users.jpierro = import ./home.nix;
          };
        }
      ];
    };

    # homeConfigurations.jpierro = inputs.home-manager.lib.homeManagerConfiguration {
    #   pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #   extraSpecialArgs = { inherit inputs outputs;};
    #   backupFileExtension = "bak";
    #   modules = [ ./home.nix ];
    # };
  };
}
