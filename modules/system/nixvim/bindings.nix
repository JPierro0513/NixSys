{
  programs.nixvim.keymaps = [
    {
      mode = ["n" "i" "s" "x" "v"];
      key = "<C-s>";
      action = "<esc>:w<cr>";
    }
  ];
}
