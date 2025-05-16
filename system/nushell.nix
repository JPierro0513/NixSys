{pkgs, ...}: {
  programs.nushell = {
    enable = true;
    shellAliases = {
      ls = "ls | sort-by type";
      la = "ls -a";
      l = "ls";
      lt = "ls **/*";
      fg = "job unfreeze";
      cat = "bat";
    };
    extraConfig = ''
      let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
      }
      $env.config = {
        show_banner: false,
        completions: {
          case_sensitive: false
          quick: true
          partial: true
          algorithm: "fuzzy"
          external: {
            enable: true
            max_results: 100
            completer: $carapace_completer
          }
        }
      }

      $env.PROMPT_COMMAND_RIGHT = {||}

      zoxide init nushell --cmd cd | save -f ~/.zoxide.nu
      source ~/.zoxide.nu
      alias fuck = thefuck $"(history | last 1 | get command | get 0)"
    '';
  };
  carapace.enable = true;
  carapace.enableNushellIntegration = true;

  starship = {
    enable = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };
}
