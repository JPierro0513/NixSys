# This file defines overlays
{...}: {
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

    neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs (oa: rec {
      version = "v0.11.0";
      src = final.pkgs.fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = "${version}";
        sha256 = "sha256-UVMRHqyq3AP9sV79EkPUZnVkj0FpbS+XDPPOppp2yFE=";
      };
      buildInputs = prev.neovim-unwrapped.buildInputs ++ [final.pkgs.utf8proc];
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
