return {{
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.4", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
    -- dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      -- Enable autosnippets
      require("luasnip").config.setup({ enable_autosnippets = true })
    end,
},
{
    "iurimateus/luasnip-latex-snippets.nvim",
    -- This plugin needs LuaSnip and VimTeX
    dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require('luasnip-latex-snippets').setup()
    end,
    ft = "tex", -- Only load for LaTeX files
  },
{
    "lervag/vimtex",
    lazy = false, -- Recommended by author to not lazy-load
    init = function()
      vim.g.vimtex_view_method = "zathura" -- Or your PDF viewer
    end
  }

}
