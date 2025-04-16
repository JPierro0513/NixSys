{pkgs, ...}: {
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;

      extraPackages = with pkgs; [sddm-chili-theme];
      theme = "chili";
      # themedir = "${pkgs.sddm-astronaut}/share/sddm/themes/astronaut";
    };
  };
}
