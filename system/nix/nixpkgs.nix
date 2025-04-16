{fetchFromGitHub, ...}: {
  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      (final: _prev: import ../../pkgs final.pkgs) # custom packages
      (final: prev: {
        # Any modifications to existing packages
        zed-editor = prev.zed-editor.overrideAttrs (finalAttrs: rec {
          # pname = "zed-editor";
          version = "0.182.8";
          src = fetchFromGitHub {
            owner = "zed-industries";
            repo = "zed";
            tag = "v${version}";
            hash = "";
          };
        });
      })
    ];
  };
}
