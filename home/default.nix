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
        
      ];
      inherit extraSpecialArgs pkgs;
    };
  };
}
