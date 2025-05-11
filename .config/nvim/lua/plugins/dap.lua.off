return {
  {
    "mfussenegger/nvim-dap", 
    keys = {
    { "<leader>dD", "", desc = "+debug", mode = {"n", "v"} },
      { "<leader>dB", function() 
        require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) 
      end, desc = "Breakpoint Condition" },
      { "<leader>db", function() 
        require("dap").toggle_breakpoint() 
      end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() 
        require("dap").continue() 
      end, desc = "Continue" },
      { "<leader>da", function() 
        require("dap").continue({ before = get_args }) 
      end, desc = "Run with Args" },
      { "<leader>dC", function() 
        require("dap").run_to_cursor() 
      end, desc = "Run to Cursor" },
      { "<leader>dg", function() 
        require("dap").goto_() 
      end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() 
        require("dap").step_into() 
      end, desc = "Step Into" },
      { "<leader>dj", function() 
        require("dap").down() 
      end, desc = "Down" },
      { "<leader>dk", function() 
        require("dap").up() 
      end, desc = "Up" },
      { "<leader>dl", function() 
        require("dap").run_last() 
      end, desc = "Run Last" },
      { "<leader>do", function() 
        require("dap").step_out() 
      end, desc = "Step Out" },
      { "<leader>dO", function() 
        require("dap").step_over() 
      end, desc = "Step Over" },
      { "<leader>dp", function() 
        require("dap").pause() 
      end, desc = "Pause" },
      { "<leader>dr", function() 
        require("dap").repl.toggle() 
      end, desc = "Toggle REPL" },
      { "<leader>ds", function() 
        require("dap").session() 
      end, desc = "Session" },
      { "<leader>dt", function() 
        require("dap").terminate() 
      end, desc = "Terminate" },
      { "<leader>dw", function() 
        require("dap.ui.widgets").hover() 
      end, desc = "Widgets" },    
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap", 
    },
    config = function()
      require("mason-nvim-dap").setup({
        automatic_installation = false,
        ensure_installed = { 
          "delve",
          "jq",
        },
        handlers = {
          function(config)
            require('mason-nvim-dap').default_setup(config)
          end,
        },
      })

      vim.api.nvim_set_hl(0, "DapStoppedLine", 
      { default = true, link = "Visual" })
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      { "<leader>du", function() 
        require("dapui").toggle({ }) 
      end, desc = "Dap UI" },
      { "<leader>de", function() 
        require("dapui").eval() 
      end, desc = "Eval", mode = {"n", "v"} },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      dapui.setup()

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
    end
  }, 
  {
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
}
