return {
  {
    "FotiadisM/tabset.nvim",
    event = "VeryLazy",
    config = function()
      require("tabset").setup({
        defaults = {
          tabwidth = 4,
          expandtab = true,
        },
        languages = {
          go = {
            tabwidth = 4,
            expandtab = false,
          },
          {
            filetypes = { "c", "json", "yaml" },
            config = {
              tabwidth = 2,
            },
          },
        },
      })
    end,
  },
}
