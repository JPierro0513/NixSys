let
  laptop = [
    ./core/boot.nix
    ./core/default.nix

    ./hardware/graphics.nix
    ./hardware/bluetooth.nix

    ./network/default.nix

    ./programs

    ./services
    ./services/greetd.nix
    ./services/pipewire.nix
    ./services/power.nix
  ];
in {
  inherit laptop;
}
