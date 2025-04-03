{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  system,
  ...
}: {
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    extraOptions = ''download-buffer-size = 500000000'';
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "";
      nix-path = config.nix.nixPath;
      substituters = [
        "https://nix-community.cachix.org"
        "https://chaotic-nyx.cachix.org"
        "https://cosmic.cachix.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      ];
    };
    channel.enable = false;
    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  nixpkgs = {
    inherit system;
    config = {
      allowUnfree = true;
    };
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "us";
    useXkbConfig = true; # use xkb.options in tty.
  };
  services.xserver.xkb.layout = "us";

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [mesa glxinfo rocmPackages.clr.icd];
    };
    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.fish;
    users.jpierro = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "audio" "video"];
    };
  };
  environment.localBinInPath = true;
  services.getty.autologinUser = "jpierro";

  system.stateVersion = "25.05"; # Did you read the comment?
}
