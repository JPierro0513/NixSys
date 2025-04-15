{
  imports = [
    # editors
    ../../editors/zed
    ../../editors/neovim

    # services
    ../../services/wayland/hypridle.nix

    # media services
    ../../services/media/playerctl.nix

    # software
    ../../software
    ../../software/wayland

    # system services
    ../../services/system/gpg-agent.nix
    ../../services/system/polkit-agent.nix
    ../../services/system/power-monitor.nix
  ];
}
