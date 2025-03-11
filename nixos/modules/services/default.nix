{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./thunar.nix
  ];

  # services.xserver.enable = true;
  # services.displayManager.lightdm.enable = false;
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  # services.xserver.desktopManager.budgie.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    environmentVariables = {
      HCC_AMDGPU_TARGET = "gfx900"; # used to be necessary, but doesn't seem to anymore
    };
    rocmOverrideGfx = "9.0.0";
  };
}
