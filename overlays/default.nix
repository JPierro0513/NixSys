{inputs}:
[
inputs.neovim-nightly-overlay.overlays.default

(final: prev: {
  zed-editor = prev.zed-editor.overrideAttrs (oldAttrs: {
    postPatch =
      ''
        substituteInPlace $cargoDepsCopy/webrtc-sys-*/build.rs \
        --replace-fail "cargo:rustc-link-lib=static=webrtc" "cargo:rustc-link-lib=dylib=webrtc"
      ''
      + ''
        substituteInPlace script/generate-licenses \
        --replace-fail 'CARGO_ABOUT_VERSION="0.6"' 'CARGO_ABOUT_VERSION="0.7.1"'
      '';
  });
})
]


# {inputs, ...}: {
#   additions = final: _prev: import ../packages final.pkgs;
#
#   modifications = final: prev: {
#     zed-editor = prev.zed-editor.overrideAttrs (oldAttrs: {
#       postPatch =
#         ''
#           substituteInPlace $cargoDepsCopy/webrtc-sys-*/build.rs \
#           --replace-fail "cargo:rustc-link-lib=static=webrtc" "cargo:rustc-link-lib=dylib=webrtc"
#         ''
#         # nixpkgs ships cargo-about 0.7.1 now, which is a seamless upgrade from 0.6
#         + ''
#           substituteInPlace script/generate-licenses \
#           --replace-fail 'CARGO_ABOUT_VERSION="0.6"' 'CARGO_ABOUT_VERSION="0.7.1"'
#         '';
#     });
#   };
#
#   # When applied, the unstable nixpkgs set (declared in the flake inputs) will
#   # be accessible through 'pkgs.unstable'
#   unstable-packages = final: _prev: {
#     unstable = import inputs.nixpkgs-unstable {
#       system = final.system;
#       config.allowUnfree = true;
#     };
#   };
# }
