_: {
  imports = [./terminal];

  home = {
    username = "jpierro";
    homeDirectory = "/home/jpierro";
    stateVersion = "25.05";
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;
}
