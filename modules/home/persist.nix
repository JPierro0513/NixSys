{
  home.persistence."/persist/home/jpierro" = {
    allowOther = true;
    directories = [
      "Downloads"
      "Documents"
      "Pictures"
      "Projects"
      "wallpapers"
      ".zen"
      ".local/share/mime"
      ".local/share/zap"
      ".local/share/nvim"
      ".local/share/zed"
      ".local/share/keyrings"
      ".local/share/zoxide"
      ".local/share/Cockatrice"
      ".config/zed"
      ".config/nvim"
      ".config/hypr"
      ".config/zsh"
      ".config/git"
      ".config/gh"
      ".config/astal"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    files = [
      ".zshenv"
    ];
  };
}
