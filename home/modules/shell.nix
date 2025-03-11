{
  programs.zsh = {
    enable = true;
    shellAliases = {
      "ls" = "eza -1 --icons --group-directories-first --git";
      "cat" = "bat";
      "nupdate" = "sudo nixos-rebuild switch --flake /etc/nixos#";
      "nlean" = "sudo nix-collect-garbage -d";
    };
    history.size = 10000;
    history.ignoreAllDups = true;
    # history.path = "$HOME/.zsh_history";
    # history.ignorePatterns = ["rm *" "pkill *" "cp *"];
    antidote = {
      enable = true;
      plugins = [''
        zdharma-continuum/fast-syntax-highlighting kind:defer
        zsh-users/zsh-autosuggestions kind:defer

        ohmyzsh/ohmyzsh path:lib/thefuck.zsh
        ohmyzsh/ohmyzsh path:lib/git.zsh

        romkatv/powerlevel10k
      ''];
    };
    initExtra = ''
      
      autoload -Uz compinit; compinit

      # Set up fzf key bindings and fuzzy completion
      source <(fzf --zsh)

      # Setup zoxide on cd
      eval "$(zoxide init zsh --cmd cd)"

      # Load powerlevel10k theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
}