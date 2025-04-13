{...}: {
  additions = final: super: {
    thundery = super.callPackage ./thundery.nix {};
    MtgDesktopCompanion = super.callPackage ./mtgdesktopcompanion.nix {};
  };
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };
}
