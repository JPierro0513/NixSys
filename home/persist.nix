{ inputs, ... }:
{
  imports = [ inputs.impermanence.homeManagerModules.impermanence ];

  home.persistence."/persistent/home/jpierro" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Projects"
      # {
      #   directory = ".local/share/Steam";
      #   method = "symlink";
      # }
    ];
    # files = [
    #   ".screenrc"
    # ];
    allowOther = true;
  };
}
