_: {
  nixpkgs = {
    config.allowUnfree = true;

    overlays =
      (final: _prev: import ../../pkgs final.pkgs) # Custom packages
      ++ [
        (final: prev: {
          # Any modifications to existing packages
          zed-editor = prev.zed-editor.overrideAttrs (oldAttrs: {
            version = "0.182.8";
          });
        })
      ];
  };
}
