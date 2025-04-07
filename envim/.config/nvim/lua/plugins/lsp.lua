return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
    },

    opts = {},

    config = function(_, opts)
      require("mason").setup(opts)

      local registry = require("mason-registry")

      local function setup_lsp(name, config)
        local s, p = pcall(registry.get_package, name)
        if s and not p:is_installed() then
          p:install()
        end
        local nvim_lsp = require("mason-lspconfig.mappings.server").package_to_lspconfig[name]
        require("lspconfig")[nvim_lsp].setup(config)
      end

      local on_attach = function(_, bufnr)
        local os = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, os)
        -- vim.keymap.set("n", "gr", vim.lsp.buf.references, os)
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references theme=dropdown<CR>", os)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, os)

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, os)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, os)
      end

      setup_lsp("lua-language-server", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
        on_attach = on_attach,
      })

      setup_lsp("rust-analyzer", {
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

      vim.cmd("LspStart")

      vim.diagnostic.config({
        virtual_text = true,
        virtual_lines = true,
        update_in_insert = true,
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

      vim.g.cpp = {
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
