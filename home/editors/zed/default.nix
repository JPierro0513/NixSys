{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    zed-editor
    nodejs
    vscode-vscode-langservers-extracted
    nil
    nixd
    stylua
    lua-language-server
  ];
}
