{
  services = {
    logind = {
      powerKey = "suspend";
      # lidSwitch = "ignore";
      # lidSwitchExternalPower = "lock";
    };

    power-profiles-daemon.enable = true;

    # battery info
    upower = {
      enable = true;
      percentageLow = 30;
      percentageCritical = 20;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };
  };
}
