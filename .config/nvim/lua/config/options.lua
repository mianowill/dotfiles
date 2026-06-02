-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.snacks_animate = false
vim.opt.clipboard = ""
vim.g.ai_cmp = false
vim.g.autoformat = false
vim.o.autochdir = false

vim.opt.shiftwidth = 0
vim.opt.softtabstop = 0
vim.opt.tabstop = 3
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.formatoptions:remove({"r", "o"}) -- don't continue comments on new line
