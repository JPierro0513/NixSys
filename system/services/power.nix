{
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

  powerManagement = {
    enable = true;
    powerDownCommands = ''
      # Lock all sessions
      loginctl lock-sessions

      # Wait for lockscreen(s) to be up
      sleep 1
    '';
  };

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

  services.upower = {
    enable = true;
    percentageLow = 30;
    percentageCritical = 20;
    percentageAction = 10;
    criticalPowerAction = "Hibernate";
  };
}
