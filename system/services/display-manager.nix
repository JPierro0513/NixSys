{pkgs, ...}: let
  theme-ver = "1.5.1";
  theme-src = pkgs.fetchFromGitHub {
    owner = "EricKotato";
    repo = "sddm-slice";
    rev = theme-ver;
    hash = "sha256-1AxRM2kHOzqjogYjFXqM2Zm8G3aUiRsdPDCYTxxQTyw=";
  };
in {
  services.displayManager = {
    sessionPackages = [pkgs.niri];
    sddm = {
      enable = true;
      wayland.enable = true;
      extraPackages = [
        (pkgs.stdenv.mkDerivation {
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
