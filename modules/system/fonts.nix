{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      monaspace
      roboto
      rubik
      source-serif-pro
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
      font-awesome
      material-design-icons
    ];
    fontconfig.defaultFonts = {
      monospace = ["Monaspace Radon"];
      sansSerif = ["Roboto"];
      serif = ["Source Serif Pro"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
