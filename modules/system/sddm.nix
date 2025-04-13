{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = true;
    wayland = true;
    extraPackages = [pkgs.sddm-chili-theme];
    theme = "chili";
  };
}
