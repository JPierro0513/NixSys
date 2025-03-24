{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gdb
    cmake
    clang
    gnumake
    lua
    lua-language-server
    gjs
    nodejs
    python3
    python3Packages.pip
    python3Packages.pynvim
    python3Packages.pygobject3
    python3Packages.psutil
    temurin-bin
    go
    cargo
    nil
    nixd
    alejandra
    hyprls
  ];
}
