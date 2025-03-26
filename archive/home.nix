{inputs, ...}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs;};
    users.jpierro = {
      imports = [
        # inputs.impermanence.homeManagerModules.impermanence
        # inputs.ags.homeManagerModules.ags

        # ./modules/home/persist.nix
        ./modules/home/theming.nix
        ./modules/home/packages
      ];

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

      # xdg.mimeApps = {
      #   enable = true;
      #   defaultApplications = {
      #     "text/html" = "zen-twilight.desktop";
      #     "x-scheme-handler/http" = "zen-twilight.desktop";
      #     "x-scheme-handler/https" = "zen-twilight.desktop";
      #     "x-scheme-handler/about" = "zen-twilight.desktop";
      #     "x-scheme-handler/unknown" = "zen-twilight.desktop";
      #   };
      # };
    };
  };
}
