{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    wl-clipboard
    cliphist
    grimblast
    hyprpaper
    hypridle
    hyprlock
    hyprpolkitagent
    mako
    waybar
    rofi-wayland
    anyrun
    ags
    astal.astal4

    ghostty
    foot

    inputs.zen-browser.packages.${system}.twilight

    zed-editor
    code-cursor
    vscode

    fd
    fzf
    ripgrep
    eza
    bat
    zoxide
    yazi
    superfile
  ];

  programs.git = {
    enable = true;
    userName = "JPierro0513";
    userEmail = "jmpierro0513@gmail.com";
  };
}
