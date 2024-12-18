local opt = vim.opt

vim.cmd([[
  syntax enable
  setlocal spell spelllang=en_us
]])

opt.number = true
opt.relativenumber = true

opt.cursorline = true

opt.syntax = "on"

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

opt.wildmode = "longest,list"
opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")
