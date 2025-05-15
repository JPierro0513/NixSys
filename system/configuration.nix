{
  # config,
  lib,
  pkgs,
  inputs,
  config,
  ...
}: {
  nix = let
    flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
  in {
    registry = lib.mapAttrs (_: v: {flake = v;}) flakeInputs;
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "/etc/nix/registry.json";
      keep-derivations = true;
      keep-outputs = true;
      trusted-users = ["root" "@wheel"];
      accept-flake-config = false;
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://niri.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
  };

  boot = {
    kernelModules = ["kvm-amd" "amdgpu"];
    kernelParams = [
      "amd_pstate=active"
      "amd_iommu"
      "mitigations=off"
      "ideapad_laptop.allow_v4_dytc=Y"
      "nvme_core.default_ps_max_latency_us=0"
      "quiet"
    ];
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;
      "kernel.nmi_watchdog" = 0;
    };
    extraModprobeConfig = ''options bluetooth disable_ertm=1 '';
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  # Don't wait for network startup
  systemd.services.NetworkManager-wait-online.serviceConfig.ExecStart = ["" "${pkgs.networkmanager}/bin/nm-online -q"];

  security = {
    tpm2.enable = true;
    rtkit.enable = true;
    pam.services.hyprlock.text = "auth include login";
    sudo.wheelNeedsPassword = false;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ALL = "en_US.UTF-8";
    };
  };

  time.timeZone = "America/New_York";
  console.keyMap = "us";

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  hardware.brillo.enable = true;

  users.users.jpierro = {
    isNormalUser = true;
    shell = pkgs.nushell;
    extraGroups = ["wheel" "audio" "video" "networkmanager" "dialout"];
  };

  system.stateVersion = "25.05";
}
