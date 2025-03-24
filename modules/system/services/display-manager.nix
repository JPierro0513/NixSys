# {pkgs, ...}:
{
  # environment.systemPackages = with pkgs; [sddm-chili-theme];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  # services.displayManager.sddm.theme = "chili";
}
