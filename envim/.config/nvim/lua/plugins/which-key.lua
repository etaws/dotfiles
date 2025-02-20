return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    disable = false,
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({})
    end,
  },
}
