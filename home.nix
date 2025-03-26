{inputs, ...}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs;};
    users.jpierro = {
      imports = [
        ./modules/home/theming.nix
        ./modules/home/packages
      ];

      # nixpkgs.config.allowUnfree = true;

      home = {
        stateVersion = "25.05";
        username = "jpierro";
        homeDirectory = "/home/jpierro";
      };
      programs.home-manager.enable = true;

      programs.git = {
        enable = true;
        userName = "JPierro0513";
        userEmail = "jmpierro0513@gmail.com";
      };

      programs.gh = {
        enable = true;
        gitCredentialHelper = {
          enable = true;
        };
      };
    };
  };
}
