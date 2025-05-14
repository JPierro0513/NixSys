{
  stdenv,
  fetchFromGitHub,
  pkgs,
  ...
}: let
  theme-ver = "1.5.1";
  theme-src = fetchFromGitHub {
    owner = "EricKotato";
    repo = "sddm-slice";
    rev = theme-ver;
    hash = "";
  };
in {
  services.displayManager = {
    sessionPackages = [pkgs.niri];
    sddm = {
      enable = true;
      wayland.enable = true;
      extraPackages = [
        (stdenv.mkDerivation {
          pname = "sddm-slice";
          version = theme-ver;
          src = theme-src;
          dontBuild = true;
          installPhase = ''
            mkdir -p $out/share/sddm/themes
            cp -aR $src $out/share/sddm/themes/slice
          '';
        })
      ];
      theme = "slice";
    };
  };
}
