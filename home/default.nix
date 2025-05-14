{
  self,
  inputs,
  ...
}: let
  extraSpecialArgs = {inherit inputs self;};
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  pkgs = import inputs.nixpkgs {
    config.allowUnfree = true;
    overlays = [
      inputs.niri.overlays.niri

      (final: _prev: import "${self}/packages" final.pkgs)
    ];
  };
in {
  flake.homeConfiguration = {
    "jpierro@nixos" = homeManagerConfiguration {
      modules = [
        ./services
        ./programs
        ./stylix
      ];
      inherit extraSpecialArgs pkgs;
    };
  };
}
