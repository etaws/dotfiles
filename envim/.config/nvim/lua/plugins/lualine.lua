return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end
      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = { error = " ", warn = " " },
        -- symbols = { error = "  ", warn = "  " },
        colored = false,
        update_in_insert = false,
        always_visible = true,
      }

      local diff = {
        "diff",
        colored = false,
        symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
        cond = hide_in_width,
      }

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "toggleterm" },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", diff, diagnostics },
          lualine_c = {
            {
              "filename",
              file_status = true, -- displays file status (readonly status, modified status)
              path = 2, -- 0 = just filename, 1 = relative path, 2 = absolute path
              shorting_target = 30, -- Shortens path to leave 40 space in the window
              -- for other components. Terrible name any suggestions?
            },
          },
          lualine_x = {
            "encoding",
            "fileformat",
            {
              "filetype",
              colored = true, -- displays filetype icon in color if set to `true
              icon_only = false, -- Display only icon for filetype
            },
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },
}
