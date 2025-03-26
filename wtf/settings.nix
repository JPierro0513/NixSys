{
  nix = {
    extraOptions = ''download-buffer-size = 500000000'';
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command flakes"
      ];
      substituters = [
        # "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://chaotic-nyx.cachix.org"
        "https://walker.cachix.org"
      ];
      trusted-public-keys = [
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      ];
    };
  };
}
