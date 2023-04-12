return {
  {
    "luukvbaal/nnn.nvim",
    config = function()
      require("nnn").setup({
        explorer = {
          cmd = "nnn", -- command overrride (-F1 flag is implied, -a flag is invalid!)
          width = 24, -- width of the vertical split
          side = "topleft", -- or "botright", location of the explorer window
          session = "", -- or "global" / "local" / "shared"
          tabs = true, -- seperate nnn instance per tab
        },
        picker = {
          cmd = "nnn", -- command override (-p flag is implied)
          style = {
            width = 0.9, -- percentage relative to terminal size when < 1, absolute otherwise
            height = 0.8, -- ^
            xoffset = 0.5, -- ^
            yoffset = 0.5, -- ^
            border = "single", -- border decoration for example "rounded"(:h nvim_open_win)
          },
          session = "", -- or "global" / "local" / "shared"
        },
        auto_open = {
          setup = nil,
          tabpage = nil,
          empty = false,
          ft_ignore = {
            "gitcommit",
          },
        },
        auto_close = false,
        replace_netrw = nil,
        mappings = {},
        windownav = {
          left = "<C-w>h",
          right = "<C-w>l",
        },
      })
    end,
    keys = {
      { "<leader>bb", "<cmd>NnnPicker<CR>", mode = "n" },
    },
  },
}
