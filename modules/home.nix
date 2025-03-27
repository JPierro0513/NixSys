{
  inputs,
  outputs,
  ...
}: {
  home-manager = {
    # useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs outputs;};
    users.jpierro = {
      imports = [
        ./home/theming.nix
        ./home/packages
      ];

      home = {
        stateVersion = "25.05";
        username = "jpierro";
        homeDirectory = "/home/jpierro";
      };

      programs.home-manager.enable = true;

      nixpkgs = {
        config.allowUnfree = true;
        overlays = [
          inputs.neovim-nightly-overlay.overlays.default

          outputs.overlays.additions
          outputs.overlays.modifications
        ];
      };

      # programs.git = {
      #   enable = true;
      #   userName = "JPierro0513";
      #   userEmail = "jmpierro0513@gmail.com";
      # };

      # programs.gh = {
      #   enable = true;
      #   gitCredentialHelper = {
      #     enable = true;
      #   };
      # };
    };
  };
}
