{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    clang
    python3
    python3Packages.pynvim
    nodejs
    lua
    lua-language-server
    hyprls
    cargo
    nil
    nixd
    alejandra
    openjdk21
  ];
}
