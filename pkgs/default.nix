{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      thundery = pkgs.callPackage ./thundery {};
      MtgDesktopCompanion = pkgs.callPackage ./MtgDesktopCompanion.nix {};
    };
  };
}
