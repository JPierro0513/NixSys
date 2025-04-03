{
  inputs,
  outputs,
  pkgs,
  system,
  ...
}: {
  home-manager = {
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs outputs pkgs system;};
    users.jpierro = {
      imports = [
        ./modules/home.nix
        ./modules/theming.nix
      ];

      home = {
        username = "jpierro";
        homeDirectory = "/home/jpierro";
      };

      programs.home-manager.enable = true;

      nixpkgs = {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          outputs.overlays.additions
          outputs.overlays.modifications
        ];
      };

      home.stateVersion = "25.05";
    };
  };
}
