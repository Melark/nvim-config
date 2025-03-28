return {
  {
    "nvim-neotest/neotest",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
      "marilari88/neotest-vitest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vitest")({
            vitestCommand = "npx vitest run",
          }),
          require("neotest-go"),
        },
      })

      vim.keymap.set("n", "<leader>te", require("neotest").summary.toggle, { desc = "explore [T]ests" })
      vim.keymap.set("n", "<leader>tc", require("neotest").run.run, { desc = "Run [T]est at [C]ursor" })
      vim.keymap.set("n", "<leader>tf", function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, { desc = "Run [T]est at [F]ile" })
      vim.keymap.set("n", "<leader>tC", function()
        require("neotest").run.run({ strategy = "dap" })
      end, { desc = "debug [T]est at [C]ursor" })
      vim.keymap.set("n", "<leader>tF", function()
        require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
      end, { desc = "Debug [T]est at [F]ile" })
    end,
  },
}
