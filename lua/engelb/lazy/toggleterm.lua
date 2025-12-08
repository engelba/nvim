function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  end

return {
    {'akinsho/toggleterm.nvim', version = "*", config = function() 
            require("toggleterm").setup({
      -- open_mapping = [[<c-\>]], -- Set the keymap to open the terminal
      direction = 'float', -- Use a floating window by default
        start_in_insert = true,
        insert_mappings = true,
      float_opts = {
        border = 'curved', -- Optional: style the border
      },
    })

    vim.keymap.set({'n', 't'}, '<A-t>', '<cmd>ToggleTerm<cr>', {noremap = true, silent = true, desc = "Toggle terminal"})
vim.keymap.set('n', '<A-b>', '<cmd>ToggleTerm size=15 direction=horizontal<cr>', {
      noremap = true,
      silent = true,
      desc = 'Toggle bottom terminal',
    })

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end
    
    }
}
