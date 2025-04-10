return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    event = "VeryLazy",
    --dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    config = function()
      require("render-markdown").setup({
        enabled = false,
        anti_conceal = { enabled = false },
        file_types = { "markdown" },
        heading = {},
        code = {},
        link = {},
      })
    end,

    vim.api.nvim_set_keymap("n", "<leader>mk", "<cmd>RenderMarkdown toggle<CR>", { noremap = true, silent = true }),
  },
}
