return {

  ---------------------------------------------------------------------------
  -- Treesitter Go parsers
  ---------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "go", "gomod", "gowork", "gosum" },
    },
  },

  ---------------------------------------------------------------------------
  -- Mason tools for Go
  ---------------------------------------------------------------------------
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "goimports",
        "gofumpt",
        "gomodifytags",
        "impl",
        "golangci-lint",
        "delve",
      },
    },
  },

  ---------------------------------------------------------------------------
  -- Debugging (DAP + dap-go + UI + gutter icons)
  ---------------------------------------------------------------------------
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      require("dap-go").setup()
      dapui.setup()

      -- Auto open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- Highlight line under debugger
      vim.cmd [[
        highlight DapStoppedLine guibg=#3e4452 guifg=NONE
      ]]

      -- Gutter icons
      vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "🟧", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "⚪", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "DapStoppedLine", linehl = "DapStoppedLine", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "📌", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
    end,
    keys = {
      -- Breakpoints
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>db", function() require("dap").set_breakpoint() end, desc = "Set Conditional Breakpoint" },

      -- Debug control
      { "<F5>", function() require("dap").continue() end, desc = "Start/Continue Debugging" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Step Out" },

      -- DAP UI
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last Debug Session" },
    },
  },

  ---------------------------------------------------------------------------
  -- Neotest for Go
  ---------------------------------------------------------------------------
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang",
    },
    keys = {
      { "<leader>tn", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run test file" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run last test" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Open test output" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
    },
    opts = function(_, opts)
      opts.adapters = {
        require("neotest-golang")({ dap_go_enabled = true }),
      }
    end,
  },

  ---------------------------------------------------------------------------
  -- Refactoring tools
  ---------------------------------------------------------------------------
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      -- Normal mode
      { "<leader>re", function() require("refactoring").refactor("Extract Function") end, desc = "Extract Function" },
      { "<leader>rf", function() require("refactoring").refactor("Extract Function To File") end, desc = "Extract Function To File" },
      { "<leader>rv", function() require("refactoring").refactor("Extract Variable") end, desc = "Extract Variable" },
      { "<leader>ri", function() require("refactoring").refactor("Inline Variable") end, desc = "Inline Variable" },
      -- LSP rename
      { "<leader>rn", function() vim.lsp.buf.rename() end, desc = "Rename Symbol" },
    },
    config = function()
      require("refactoring").setup({})
      -- Visual mode mappings
      vim.keymap.set("v", "<leader>re", [[<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], { desc = "Extract Function" })
      vim.keymap.set("v", "<leader>rv", [[<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], { desc = "Extract Variable" })
    end,
  },

  ---------------------------------------------------------------------------
  -- Optional icons for Go files
  ---------------------------------------------------------------------------
  {
    "nvim-mini/mini.icons",
    opts = {
      file = {
        [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- LSP: gopls
  ---------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = { unusedparams = true, shadow = true },
              staticcheck = true,
              gofumpt = true
            },
          },
        },
      },
    },
  },


}
