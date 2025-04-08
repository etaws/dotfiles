return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
    vim.diagnostic.config({
      virtual_text = true,
      virtual_lines = true,
      update_in_insert = true,
    }),
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "rust_analyzer", "lua_ls", "clangd" },
        automatic_installation = false,
      })
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
      local function setup_lsp_keybindings()
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references theme=dropdown<CR>", opts)
        -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      end

      local handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
        -- Rust
        ["rust_analyzer"] = function()
          require("lspconfig").rust_analyzer.setup({
            settings = {
              ["rust-analyzer"] = {
                imports = {
                  granularity = {
                    group = "module",
                  },
                  prefix = "self",
                },
                checkOnSave = {
                  command = "clippy",
                },
              },
            },
          })
          setup_lsp_keybindings()
        end,
        -- Lua
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                  },
                },
              },
            },
          })
          setup_lsp_keybindings()
        end,
        -- C++
        ["clangd"] = function()
          require("lspconfig").clangd.setup({
            cmd = {
              "clangd",
              "--background-index",
              "--suggest-missing-includes",
              "--clang-tidy",
              "--header-insertion=iwyu",
            },
          })
          setup_lsp_keybindings()
        end,
      }
      require("mason-lspconfig").setup_handlers(handlers)
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
