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

      function transient_prompt_func
        set --local color green
	if test $transient_pipestatus[-1] -ne 0
	  set color red
	end
	echo -en (set_color brblack)"["(date "+%I:%M")"] "(set_color $color)"❱ "(set_color normal)
      end

      set fish_prompt_pwd_dir_length 3
      set hydro_multiline true
      set hydro_color_prompt green
      set hydro_color_duration yellow
      set hydro_color_pwd blue
    '';
    shellAliases = {
      "update" ="sudo nixos-rebuild switch";
      "bupdate"="sudo nixos-rebuild boot";
      "ls"="eza --icons -1 --group-directories-first --git";
      "lt"="ls --tree";
      "cat"="bat";
    };
  };
}
