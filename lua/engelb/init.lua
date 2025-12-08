require("engelb.global")
require("engelb.lsp")
require("engelb.remap")
require("engelb.set")
require("engelb.lazy_init")

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'vim,lua', -- Apply to vim and lua help/float windows
  callback = function(args)
    -- Close float window with 'q'
    vim.keymap.set('n', 'q', '<C-w>c', { buffer = args.buf })
  end
})
