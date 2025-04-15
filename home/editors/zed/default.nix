{pkgs, ...}: {
  home.packages = with pkgs; [
    zed-editor
    nodejs
    vscode-langservers-extracted
    nil
    nixd
    stylua
    lua-language-server
  ];
}
