{inputs, ...}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs;};
    users.jpierro = {
      home = {
        stateVersion = "25.05";
        username = "jpierro";
        homeDirectory = "/home/jpierro";
      };
      imports = [
        inputs.impermanence.homeManagerModules.impermanence
        inputs.ags.homeManagerModules.ags
        inputs.astal.homeManagerModules.astal

        ./modules/home/persist.nix
        ./modules/home/theming.nix
        ./modules/home/packages
      ];
      programs = {
        home-manager.enable = true;
        git.enable = true;
      };
    };
  };
}
