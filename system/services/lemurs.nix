{
  pkgs,
  inputs,
  ...
}: {
  # greetd display manager
  services.greetd = let
    session = {
      command = "${inputs.lemurs.packages.${pkgs.system}.default}/bin/lemurs";
      user = "greetd";
    };
  in {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = session;
      initial_session = session;
    };
  };

  # unlock GPG keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;

  # services.displayManager.autoLogin.enable = true;
  # services.displayManager.autoLogin.user = "linuxmobile";
}
