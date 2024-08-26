return {
  "iabdelkareem/csharp.nvim",
  dependencies = {
    "williamboman/mason.nvim", -- Required, automatically installs omnisharp
    "mfussenegger/nvim-dap",
    "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
  },
  config = function()
    require("mason").setup() -- Mason setup must run before csharp, only if you want to use omnisharp
    require("csharp").setup()

    vim.keymap.set("n", "<leader><F6>", function()
      require("csharp").run_project()
    end, { desc = "Run csharp project" })

    vim.keymap.set("n", "<leader><F5>", function()
      require("csharp").debug_project()
    end, { desc = "Run csharp project" })
  end,
}
