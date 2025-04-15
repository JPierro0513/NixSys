{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    # package = pkgs.bluez5-experimental;
    powerOnBoot = true;
    settings = {
      # make Xbox Series X controller work
      General = {
        Experimental = true;
        FastConnectable = true;
        powerOnBoot = true;
        JustWorksRepairing = "always";
        Privacy = "device";
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  # boot.extraModprobeConfig = ''options bluetooth disable_ertm=1 '';
  # systemd.user.services.telephony_client.enable = false;

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = ["network.target" "sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  environment.systemPackages = with pkgs; [bluez bluez-tools blueman];

  # services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
  #   "monitor.bluez.properties" = {
  #     "bluez5.roles" = ["a2dp_sink" "a2dp_source" "bap_sink" "bap_source" "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
  #     "bluez5.codecs" = ["aptx_hd" "aptx" "ldac" "sbc" "sbc_xq" "aac"];
  #     "bluez5.enable-sbc-xq" = true;
  #     "bluez5.enable-hw-volume" = true;
  #     "bluez5.hfphsp-backend" = "native";
  #   };
  # };
}
