{
  pkgs,
  inputs,
  ...
}: {
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    defaultEditor = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      glfw-wayland
      libusb1
    ];
  };

  programs.dconf.enable = true;
  programs.seahorse.enable = true;

  programs = {
    gamemode.enable = true;
    gamescope.enable = true;
    steam.enable = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common = {
        default = ["gnome" "gtk"];
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        "org.freedesktop.impl.portal.Screenshot" = "gnome";
        "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };
}
