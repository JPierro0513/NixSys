{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-symbols

      # normal fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji

      # My fonts
      monaspace
      rubik
      source-sans-pro
      source-serif-pro

      # nerdfonts
      nerd-fonts.symbols-only
      # nerd-fonts.departure-mono
      # departure-mono
    ];

    # causes more issues than it solves
    enableDefaultPackages = false;

    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = false;
        style = "full";
      };
      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };
      defaultFonts = let
        addAll = builtins.mapAttrs (_: v: ["Symbols Nerd Font"] ++ v ++ ["Noto Color Emoji"]);
      in
        addAll {
          serif = ["Source Serif Pro"];
          sansSerif = ["Rubik"];
          monospace = ["Monaspace Argon"];
          emoji = ["Noto Color Emoji"];
        };
    };
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
  };
}
