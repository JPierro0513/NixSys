{pkgs, ...}: {
  home.packages = with pkgs.fishPlugins; [
    pkgs.grc
    pkgs.done

    grc
    fzf-fish
    done
    forgit
    hydro
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting #

      set hydro_multiline true
      set hydro_color_prompt green

      thefuck --alias | source
      zoxide init fish --cmd cd | source
    '';
    shellAliases = {
      "cat" = "bat";
      "ls" = "eza --icons -1 --group-directories-first";
      "la" = "ls -a";
      "l" = "ls -l";
      "ll" = "la -l";
      "lt" = "ls --tree";
    };
  };
}
