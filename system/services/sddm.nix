{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    extraPackages = with pkgs; [sddm-astronaut];
    theme = "astronaut";
    themedir = "${pkgs.sddm-astronaut}/share/sddm/themes/astronaut";
  };
}
