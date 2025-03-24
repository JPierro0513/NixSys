{
  description = "A dev environment for minecraft mod development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    libs = with pkgs; [
      libpulseaudio
      libGL
      glfw
      openal
      stdenv.cc.cc.lib
      openjdk21
      gradle
    ];
  in {
    devShell.x86_64-linux = pkgs.mkShell {
      packages = [
        pkgs.deno
        pkgs.openjdk
        pkgs.gradle
        pkgs.package-version-server
      ];
      shellHook = ''
        export PATH="$PATH:$HOME/.deno/bin"
        deno install -f -A -g -n fabric https://fabricmc.net/cli
        fabric upgrade
        trap 'deno uninstall fabric;rm deno.json' EXIT
      '';
      buildInputs = libs;
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath libs;
    };
  };
}
