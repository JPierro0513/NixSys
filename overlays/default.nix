# _: {
#   additions = final: _prev: {
#     thundery = final.callPackage ./thundery {};
#   };
#   modifications = final: prev: {
#     # example = prev.example.overrideAttrs (oldAttrs: rec {
#     # ...
#     # });
#   };
# }
pkgs: {
  thundery = pkgs.callPackage ./thundery {};
}
