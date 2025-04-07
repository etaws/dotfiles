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
    "stevearc/conform.nvim",
    cmd = "Neoformat",
    event = "VeryLazy",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          rust = { "rustfmt", lsp_format = "fallback" },
          cpp = { "clang-format-custom" },
        },
        formatters = {
          ["clang-format-custom"] = {
            command = "clang-format",
            args = { "--style=file" },
            stdin = true,
          },
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
}
