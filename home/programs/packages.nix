{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    wget
    curl
    git
    gh

    unzip
    gzip
    kdePackages.ark

    kdePackages.kpmcore
    kdePackages.partitionmanager

    btop
    nitch
    killall
    inputs.nsearch.packages.${pkgs.system}.default
    meld

    eza
    bat
    fd
    ripgrep
    fzf
    zoxide
    thefuck
    yazi
    viu
    imagemagick

    libgcc
    libclang
    nodejs
    nodePackages.npm
    python3
    python3Packages.pip
    rustup
    nixd
    nil
    alejandra
    lua-language-server
    vscode-langservers-extracted
  ];
}
