{pkgs,...}:
{
  environment.systemPackages = with pkgs.fishPlugins; [
    grc
    pkgs.grc
    done
    fzf-fish
    forgit
    hydro
    pisces
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };
}
