return {
  {
    "tanvirtin/vgit.nvim",
    enabled = false,
    cmd = "VGit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("vgit").setup({
        keymaps = {
          ["n <C-k>"] = function()
            require("vgit").hunk_up()
          end,
          ["n <C-j>"] = function()
            require("vgit").hunk_down()
          end,
          ["n <leader>gq"] = function()
            require("vgit").project_hunks_qf()
          end,
          ["n <leader>gx"] = function()
            require("vgit").toggle_diff_preference()
          end,
        },
      })
    end,
    keys = {
      { "<leader>gd", "<cmd>VGit project_diff_preview<CR>", mode = "n" },
    },
  },
}
