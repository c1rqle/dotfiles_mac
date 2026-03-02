-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd([[set guicursor=n:hor100,v-c-i:ver100]])

-- Tmux window renaming for file buffers
if vim.env.TMUX then
  local autocmd = vim.api.nvim_create_autocmd
  autocmd("BufEnter", {
    callback = function()
      local filename = vim.fn.expand("%:t")
      if filename ~= "" then
        vim.fn.system("tmux rename-window '" .. filename .. "'")
      end
    end,
  })
  autocmd("VimLeave", {
    callback = function()
      vim.fn.system("tmux setw automatic-rename on")
    end,
  })
end
