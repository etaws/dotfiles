return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    event = "VeryLazy",
    config = function()
      require("render-markdown").setup({
          enabled = false,
          anti_conceal = { enabled = false },
 --         sign = { enabled = false },
          file_types = { 'markdown' },
          heading = {
--              sign = false,
--              icons = { ' ', ' ', ' ', ' ', ' ', ' ' },
--              signs = { ' ' },
          },
          code = {
 --             sign = false,
          },
          link = {
  --            enabled = false,
  --            hyperlink = ' ',
          },
      })
    end,

    vim.api.nvim_set_keymap("n", "<leader>mk", "<cmd>RenderMarkdown toggle<CR>", { noremap = true, silent = true })
  },
}
