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
      home = {
        username = "jpierro";
        homeDirectory = "/home/jpierro";
      };

      programs.home-manager.enable = true;

      # nixpkgs = {
      #   config.allowUnfree = true;
      #   overlays = [
      #     inputs.neovim-nightly-overlay.overlays.default

      #     outputs.overlays.additions
      #     outputs.overlays.modifications
      #   ];
      # };

      home.stateVersion = "25.05";
    };
  };
}
