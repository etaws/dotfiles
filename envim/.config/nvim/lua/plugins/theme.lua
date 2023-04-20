return {
  {
    "folke/styler.nvim",
    event = "VeryLazy",
    config = function()
      require("styler").setup({
        themes = {
          --  markdown = { colorscheme = "catppuccin-mocha" },
          help = { colorscheme = "gruvbox" },
        },
      })
    end,
  },
  {
    "glepnir/zephyr-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd([[colorscheme tokyonight-storm]])
      vim.cmd([[colorscheme zephyr]])
    end,
  },
  { "ellisonleao/gruvbox.nvim", event = "VeryLazy" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "folke/tokyonight.nvim", event = "VeryLazy" },
  { "sainnhe/edge", event = "VeryLazy" },
  { "Mofiqul/vscode.nvim", event = "VeryLazy" },
  { "tjdevries/colorbuddy.vim", event = "VeryLazy" },
  { "Th3Whit3Wolf/onebuddy", event = "VeryLazy" },
  { "mhartington/oceanic-next", event = "VeryLazy" },
}
