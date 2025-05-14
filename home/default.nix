{
  self,
  inputs,
  ...
}: let
  extraSpecialArgs = {inherit inputs self;};
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
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
        {
          home = {
            username = "jpierro";
            homeDirectory = "/home/jpierro";
            stateVersion = "25.05";
          };
          programs.home-manager.enable = true;
        }
        ./services
        ./programs
        ./stylix
      ];
      inherit extraSpecialArgs pkgs;
    };
  };
}
