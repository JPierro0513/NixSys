{pkgs, ...}: {
  environment.systemPackages = with pkgs.fishPlugins; [
    grc
    pkgs.grc
    done
    fzf-fish
    forgit
    hydro
    pisces
    transient-fish
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      set -l nix_shell_info (
        if test -n "$IN_NIX_SHELL"
          echo -n "<nix-shell> "
        end
      )

      function transient_prompt_func
        set --local color green
        if test $transient_pipestatus[-1] -ne 0
          set color red
        end
        echo -en (set_color brblack)"["(date "+%I:%M")"] "(set_color $color)"❱ "(set_color normal)
      end

      # function transient_rprompt_func
      #   echo -n -s (set_color purple) "$nix_shell_info"
      # end

      function pythonEnv --description 'start a nix-shell with the given python packages' --argument pythonVersion
        if set -q argv[2]
          set argv $argv[2..-1]
        end

        for el in $argv
          set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
        end

        nix-shell -p $ppkgs
      end

      set fish_prompt_pwd_dir_length 3
      set hydro_multiline true
      set hydro_color_prompt green
      set hydro_color_duration yellow
      set hydro_color_pwd blue

      thefuck --alias | source
      zoxide init fish --cmd cd | source
    '';
    shellAliases = {
      "update" = "sudo nixos-rebuild switch";
      "bupdate" = "sudo nixos-rebuild boot";
      "ls" = "eza --icons -1 --group-directories-first --git";
      "lt" = "ls --tree";
      "cat" = "bat";
    };
  };
}
