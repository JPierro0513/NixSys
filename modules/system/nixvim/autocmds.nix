{
  programs.nixvim.autoCmd = [
    # vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    #   callback = function(event)
    #     if event.match:match("^%w%w+://") then
    #       return
    #     end
    #     local file = vim.loop.fs_realpath(event.match) or event.match
    #     vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    #   end,
    # })
    {
      event = ["BufWritePre"];
      callback = "
        function(event)
          if event.match:match('^%w%w+:[\\/][\\/]') then
            return
          end
          local file = vim.loop.fs_realpath(event.match) or event.match
          vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
        end
      ";
    }
    # vim.api.nvim_create_autocmd('BufReadPost', {
    #     desc = 'Go to the last location when opening a buffer',
    #     callback = function(args)
    #         local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    #         local line_count = vim.api.nvim_buf_line_count(args.buf)
    #         if mark[1] > 0 and mark[1] <= line_count then
    #             vim.cmd 'normal! g`"zz'
    #         end
    #     end,
    # })
    {
      event = ["BufReadPost"];
      callback = "
        function(args)
          local mark = vim.api.nvim_buf_get_mark(args.buf, '\"')
          local line_count = vim.api.nvim_buf_line_count(args.buf)
          if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd 'normal! g`\"zz'
          end
        end,
      ";
    }
    {
      event = "TextYankPost";
      callback = "function() vim.hl.on_yank { higroup = 'Visual', priority = 250 } end";
    }
    {
      event = "BufWritePre";
      callback = "function() vim.cmd [[%s/\s\+$//e]] end";
    }
  ];
}
