# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
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
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will be accessible through 'pkgs.unstable'
  # unstable-packages = final: _prev: {
  #   unstable = import inputs.nixpkgs-unstable {
  #     system = final.system;
  #     config.allowUnfree = true;
  #   };
  # };
}
# {inputs}: let
#   additions = final: _prev: import ../pkgs final.pkgs;
#
#   modifications = final: prev: {
#     zed-editor = prev.zed-editor.overrideAttrs (oldAttrs: {
#       postPatch =
#         ''
#           substituteInPlace $cargoDepsCopy/webrtc-sys-*/build.rs \
#           --replace-fail "cargo:rustc-link-lib=static=webrtc" "cargo:rustc-link-lib=dylib=webrtc"
#         ''
#         + ''
#           substituteInPlace script/generate-licenses \
#           --replace-fail 'CARGO_ABOUT_VERSION="0.6"' 'CARGO_ABOUT_VERSION="0.7.1"'
#         '';
#     });
#   };
# in [
#   inputs.neovim-nightly-overlay.overlays.default
#
#   additions
#   modifications
#
#   # (final: prev: {
#   #   zed-editor = prev.zed-editor.overrideAttrs (oldAttrs: {
#   #     postPatch =
#   #       ''
#   #         substituteInPlace $cargoDepsCopy/webrtc-sys-*/build.rs \
#   #         --replace-fail "cargo:rustc-link-lib=static=webrtc" "cargo:rustc-link-lib=dylib=webrtc"
#   #       ''
#   #       + ''
#   #         substituteInPlace script/generate-licenses \
#   #         --replace-fail 'CARGO_ABOUT_VERSION="0.6"' 'CARGO_ABOUT_VERSION="0.7.1"'
#   #       '';
#   #   });
#   # })
# ]

