{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      corefonts
      noto-fonts-emoji
      adwaita-fonts
      source-serif-pro
      rubik
      nerd-fonts.symbols-only
      maple-mono.NF
    ];
    enableDefaultPackages = true;
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
          monospace = ["Maple Mono NF"];
          emoji = ["Noto Color Emoji"];
        };
    };
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
  };
}
