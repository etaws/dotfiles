return {
  --  +------------------------------------------------------------------------------+
  --  |                              Basic enhencement                               |
  --  +------------------------------------------------------------------------------+
  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "ethanholz/nvim-lastplace",
    enabled = false,
    lazy = false,
    config = function()
      require("nvim-lastplace").setup({
        -- 那些 buffer 类型不记录光标位置
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        -- 那些文件类型不记录光标位置
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = function()
      require("indent_blankline").setup({
        -- 显示当前所在区域
        show_current_context = true,
        -- 显示当前所在区域的开始位置
        show_current_context_start = true,
        -- 显示行尾符
        show_end_of_line = true,
      })
    end,
  },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  --  +------------------------------------------------------------------------------+
  --  |                                 Programming                                  |
  --  +------------------------------------------------------------------------------+
  -- high-performance color highlighter
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({ "css", "scss", "erb", "html", "javascript" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
}
