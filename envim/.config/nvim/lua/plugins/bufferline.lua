return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        numbers = "ordinal", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        indicator = {
          icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "icon", -- 'icon' | 'underline' | 'none',
        },
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 18,
        truncate_names = true, -- whether or not tab names should be truncated
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thick", -- | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
      },
    },
    keys = {
      { "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>" },
      { "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>" },
      { "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>" },
      { "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>" },
      { "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>" },
      { "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>" },
      { "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>" },
      { "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>" },
      { "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>" },
    },
  },
}
