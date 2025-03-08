return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",
      event = { "VimEnter" },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true }
        local map = vim.api.nvim_buf_set_keymap
        map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        -- map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        map(bufnr, "n", "gr", "<cmd>Telescope lsp_references theme=dropdown<CR>", opts)
        -- map(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

        -- goto preview keymappigs
        -- map(bufnr, "n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts)
        -- map(bufnr, "n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",opts)
        -- map(bufnr, "n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", opts)
        -- map(bufnr, "n", "gf", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opts)
      end

      require("mason-lspconfig").setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({})
        end,
        -- Next, you can provide a dedicated handler for specific servers.

        -- a handler override for the `rust_analyzer`:
        ["rust_analyzer"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.rust_analyzer.setup({
            flags = { debounce_text_changes = 150 },
            settings = {
              ["rust-analyzer"] = {
                checkOnSave = {
                  command = "clippy",
                },
              },
            },

            on_attach = on_attach,
          })
        end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
            on_attach = on_attach,
          })
        end,
      })
    end,
  },
  {
    "sbdchd/neoformat",
    cmd = "Neoformat",
    event = "VeryLazy",
    config = function()
      -- 1.自动对齐
      vim.g.neoformat_basic_format_align = 1
      -- 2.自动删除行尾空格
      vim.g.neoformat_basic_format_trim = 1
      -- 3.将制表符替换为空格
      vim.g.neoformat_basic_format_retab = 0

      -- 只提示错误消息
      vim.g.neoformat_only_msg_on_error = 1

      cpp = {
        {
          exe = "clang-format",
          args = {
            "--style=file",
          },
          stdin = true,
        },
      }
      vim.g.neoformat_enabled_lua = { "stylua" }
      vim.g.neoformat_enabled_rust = { "rustfmt" }

      vim.keymap.set(
        "n",
        "<leader>cf",
        "<cmd>Neoformat<CR>",
        { noremap = true, silent = true, desc = "Format current file with Neoformat" }
      )
    end,
  },
}
