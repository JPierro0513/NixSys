_: {
  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      (final: _prev: import ../../pkgs final.pkgs) # custom packages
      (final: prev: {
        # Any modifications to existing packages
      })
    ];
  };
}
