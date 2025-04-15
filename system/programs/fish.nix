{pkgs, ...}: {
  environment.systemPackages = with pkgs.fishPlugins; [
    pkgs.fish
    pkgs.grc
    pkgs.eza
    pkgs.bat
    pkgs.zoxide
    pkgs.thefuck

    grc
    done
    fzf-fish
    forgit
    hydro
    transient-fish
    sponge
    pisces
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting

      function transient_prompt_func
        set --local color green
        if test $transient_pipestatus[-1] -ne 0
          set color red
        end
        echo -en (set_color $color)"❱ "(set_color normal)
      end

      set hydro_multiline true
      set hydro_color_prompt green
      set hydro_color_pwd blue

      thefuck --alias | source
      zoxide init fish --cmd cd | source
    '';
    shellAliases = {
      "ls" = "eza --icons -1 --group-directories-first --git";
      "lt" = "ls --tree";
      "la" = "ls -a";
      "l" = "ls -la";
      "cat" = "bat";
    };
  };
}
