{...}: {
  additions = final: super: {
    thundery = super.callPackage ./thundery.nix {};
    MtgDesktopCompanion = super.callPackage ./mtgdesktopcompanion.nix {};
    base24-schemes = super.callPackage ./base24.nix;
  };
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };
}
