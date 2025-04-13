{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.default];
  programs.spicetify = let
    spicepkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    enabledExtensions = with spicepkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
    enabledCustomApps = with spicepkgs.apps; [
      newReleases
      ncsVisualizer
    ];
    enabledSnippets = with spicepkgs.snippets; [
      rotatingCoverart
      pointer
    ];
    # theme = spicepkgs.themes.hazy;
  };
}
