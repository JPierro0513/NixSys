{pkgs, ...}: {
  services.displayManager = {
    sessionPackages = [pkgs.niri];
    # sddm = {
    #   enable = true;
    #   wayland.enable = true;
    # };
  };
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
}
