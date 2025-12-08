return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    
    ---@module 'neo-tree'
    ---@type noetree.Config
    opts = {
        close_if_last_window = false, 
        sort_case_insensitive = true,
    },
    keys = {
        -- Toggle Neotree
        { 
            "<leader>pv",
            function()
              require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
            end,
            desc = "Explorer NeoTree (Root Dir)",
        },
{
      "<leader>pb",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true })
      end,
      desc = "Buffer Explorer",
    },
    }
  }
}
