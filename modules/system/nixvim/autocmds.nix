{
  programs.nixvim.autoCmd = [
    {
      event = ["BufWritePre"];
      callback = {__raw = "
        function(event)
          if event.match:match('^%w%w+:[\\/][\\/]') then
            return
          end
          local file = vim.loop.fs_realpath(event.match) or event.match
          vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
        end
      ";};
    }
    # {
    #   event = ["BufReadPost"];
    #   callback = {__raw = "
    #     function(args)
    #       local mark = vim.api.nvim_buf_get_mark(args.buf, '\"')
    #       local line_count = vim.api.nvim_buf_line_count(args.buf)
    #       if mark[1] > 0 and mark[1] <= line_count then
    #         vim.cmd 'normal! g`\"zz'
    #       end
    #     end
    #   ";};
    # }
    {
      event = "TextYankPost";
      callback = {__raw = "function() vim.hl.on_yank { higroup = 'Visual', priority = 250 } end";};
    }
    {
      event = "BufWritePre";
      callback = {__raw = "function() vim.cmd [[%s/\s\+$//e]] end";};
    }
  ];
}
