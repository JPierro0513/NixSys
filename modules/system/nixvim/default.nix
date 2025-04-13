{
  imports = [
    ./autocmds.nix
    ./settings.nix
    ./bindings.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
