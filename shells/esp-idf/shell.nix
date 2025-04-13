let
  nixpkgs-esp-dev = builtins.fetchGit {
    url = "https://github.com/mirrexagon/nixpkgs-esp-dev.git";
  };
  pkgs = import <nixpkgs> {overlays = [(import "${nixpkgs-esp-dev}/overlay.nix")];};
in
  pkgs.mkShell {
    name = "esp-idf";

    buildInputs = with pkgs; [
      (esp-idf-full.override {
        tag = "v5.4.1";
        sha256 = "";
      })
    ];
  }
