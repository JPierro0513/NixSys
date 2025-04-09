{pkgs, ...}: {
  services.printing.enable = true;
  services.avahi.enable = true;
  services.openssh.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = ["network.target" "sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
    "monitor.bluez.properties" = {
      "bluez5.roles" = [ "a2dp_sink" "a2dp_source" "bap_sink" "bap_source" "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
      "bluez5.codecs" = [ "aptx_hd" "aptx" "ldac" "sbc" "sbc_xq" "aac" ];
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.hfphsp-backend" = "native";
    };
    # "monitor.bluez.properties" = {
    #   "bluez5.enable-sbc-xq" = true;
    #   "bluez5.enable-msbc" = true;
    #   "bluez5.enable-hw-volume" = true;
    #   "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
    # };
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    bluez
    bluez-tools
    blueman
  ];

  services.upower.enable = true;

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  powerManagement.enable = true;

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

  services.displayManager.cosmic-greeter.enable = true;
  # services.flatpak.enable = true;

  services.ollama = {
    enable = true;
  };
}
