-- Configure LSPs

-- Python LSP: Ruff & Pyright
vim.lsp.config('ruff', {
  init_options = {
    settings = {
      -- Ruff language server settings go here
			logLevel = 'debug',
    }
  }
})

vim.lsp.config('pyright', {

})

-- Markdown LSP: Marksman

vim.lsp.config('texlab', {
})

-- Enable LSPs

vim.lsp.enable('ruff')
vim.lsp.enable('pyright')
vim.lsp.enable('texlab')


-- On save setup, can be delete if comform.lua is used
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("UserLspFormatting", {}),
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client and client.supports_method("textDocument/formatting") then
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         buffer = ev.buf,
--         callback = function()
--           vim.lsp.buf.format({ bufnr = ev.buf })
--         end,
--       })
--     end
--   end,
-- })
-- 
-- -- Disable functionalities handled by PyRights
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client == nil then
--       return
--     end
--     if client.name == 'ruff' then
--       -- Disable hover in favor of Pyright
--       client.server_capabilities.hoverProvider = false
--     end
--   end,
--   desc = 'LSP: Disable hover capability from Ruff',
-- })
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(ev)
        -- Get the client and buffer number from the event
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufnr = ev.buf

        -- 1. Disable Ruff's hover to prefer Pyright
        if client and client.name == 'ruff' then
            client.server_capabilities.hoverProvider = false
        end

        -- 2. Enable format-on-save for clients that support it
        if client and client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end

        -- 3. Set keymaps, but only for this buffer
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)

        -- This is the keymap for your original question: showing the error
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts) -- Or <leader>vd like Prime

        -- Keymaps for navigating diagnostics
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    end,
})


