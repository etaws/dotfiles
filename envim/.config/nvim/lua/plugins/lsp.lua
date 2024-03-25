return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      local nvim_lsp = require("lspconfig")
      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true }
        local map = vim.api.nvim_buf_set_keymap
        map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        -- map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
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

      -- nvim-cmp supports additional completion capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- clangd setup
      nvim_lsp["clangd"].setup({
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--suggest-missing-includes",
          "--clang-tidy",
          "--completion-style=bundled",
          "--header-insertion=iwyu",
        },
        on_attach = on_attach,
        flags = { debounce_text_changes = 150 },
      })

      -- sumneko_lua location
      local runtime_path = vim.split(package.path, ";")
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")
      nvim_lsp["lua_ls"].setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT", path = runtime_path },
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
        on_attach = on_attach,
        flags = { debounce_text_changes = 150 },
      })

      -- cmake setup
      nvim_lsp["cmake"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = { debounce_text_changes = 150 },
      })

      -- rust_analyzer setup
      nvim_lsp["rust_analyzer"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = { debounce_text_changes = 150 },
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      })
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufReadPre",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("lspsaga").setup({
        debug = false,
        use_saga_diagnostic_sign = true,
        -- diagnostic sign
        error_sign = "",
        warn_sign = "",
        hint_sign = "",
        infor_sign = "",
        diagnostic_header_icon = "   ",
        -- code action title icon
        code_action_icon = " ",
        code_action_prompt = {
          enable = false,
          sign = true,
          sign_priority = 40,
          virtual_text = true,
        },
        finder_definition_icon = "  ",
        finder_reference_icon = "  ",
        max_preview_lines = 10,
        finder_action_keys = {
          open = "o",
          vsplit = "s",
          split = "i",
          quit = "q",
          scroll_down = "<C-f>",
          scroll_up = "<C-b>",
        },
        code_action_keys = {
          quit = "q",
          exec = "<CR>",
        },
        rename_action_keys = {
          quit = "<C-c>",
          exec = "<CR>",
        },
        definition_preview_icon = "  ",
        border_style = "round",
        rename_prompt_prefix = "➤",
        rename_output_qflist = {
          enable = false,
          auto_open_qflist = false,
        },
        server_filetype_map = {},
        diagnostic_prefix_format = "%d. ",
        diagnostic_message_format = "%m %c",
        highlight_prefix = false,
      })
    end,
    keys = {
      { "gh", "<cmd>Lspsaga lsp_finder<CR>", mode = "n" },
      { "K", "<cmd>Lspsaga hover_doc<CR>", mode = "n" },
      { "gd", "<cmd>Lspsaga goto_definition<CR>", mode = "n" },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "dcampos/nvim-snippy",
    },
    config = function()
      vim.o.completeopt = "menuone,noinsert,noselect"
      local cmp = require("cmp")
      cmp.setup({
        -- Enable LSP snippets
        snippet = {
          expand = function(args)
            require("snippy").expand_snippet(args.body)
            -- vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          -- Add tab support
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-s>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
        },

        -- Installed sources
        sources = {
          { name = "nvim_lsp" },
          { name = "snippy" },
          -- { name = "vsnip" },
          { name = "path" },
          { name = "buffer" },
        },
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    opts = {
      position = "left",
    },
  },
  {
    "sbdchd/neoformat",
    cmd = "Neoformat",
    config = function()
      -- 1.自动对齐
      vim.g.neoformat_basic_format_align = 1
      -- 2.自动删除行尾空格
      vim.g.neoformat_basic_format_trim = 1
      -- 3.将制表符替换为空格
      vim.g.neoformat_basic_format_retab = 0

      -- 只提示错误消息
      vim.g.neoformat_only_msg_on_error = 1
    end,
  },
}
