return {
  "mfussenegger/nvim-dap",

  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
  },

  -- stylua: ignore
  keys = {
    { "<F5>", function() require("dap").continue() end, desc = "Debug or Resume" },
    { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
    { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
    { "<S+F11>", function() require("dap").step_out() end, desc = "Toggle Breakpoint" },
    { "<C+F10>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
  },

  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("dapui").setup()
    require("dap-go").setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
