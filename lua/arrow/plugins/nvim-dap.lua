return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
      local dap = require("dap")
      local ui = require("dapui")
      ui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

      require("nvim-dap-virtual-text").setup({
        -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
            return "*****"
          end

          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
      })

      vim.keymap.set("n", "<Leader>dt", ":DapUiToggle<CR>", { desc = "Toggle DAP UI" })
      vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "DAP Continue" })
      vim.keymap.set("n", "<Leader>dr", ":lua require('dapui').open({reset = true})<CR>", { desc = "Reset DAP UI" })

      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "⏺", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )

      require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }
      -- Eval var under cursor
      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end, {desc = "Debug evaluate under cursor"})

      vim.keymap.set("n", "<F1>", dap.continue, {desc = "Debug Continue"})
      vim.keymap.set("n", "<F2>", dap.step_into, {desc = "Debug Step Into"})
      vim.keymap.set("n", "<F3>", dap.step_over, {desc = "Debug Step Over"})
      vim.keymap.set("n", "<F4>", dap.step_out, {desc = "Debug Step Out"})
        vim.keymap.set("n", "<F5>", dap.step_back, {desc = "Debug Step Back"})
      vim.keymap.set("n", "<F13>", dap.restart, {desc = "Debug Restart"})

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end

-- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
    end,
  },
}
