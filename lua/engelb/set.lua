vim.opt.number = true
vim.opt.relativenumber = true

-- ignore case in search pattern
vim.opt.ignorecase = true

-- override ignorecase if the search pattern contains uppercase
vim.opt.smartcase = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- use space instead of tabs
vim.opt.splitright = true -- vsplit to the right
vim.opt.splitbelow = true -- split below instead of above

-- Minimum number of line to maintain above and bellow the cursor
vim.opt.scrolloff = 8

-- Clipboard interactions
vim.opt.clipboard = "unnamedplus"

-- Auto indentation and smart indentation
vim.opt.smartindent = false -- add indentation after {, before }, after word in cinwords
vim.opt.autoindent = true -- match previous line indentation (default to on)

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"

vim.opt.colorcolumn = "80"

-- Update cursor information frequently
vim.opt.updatetime = 50

-- Folding
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
