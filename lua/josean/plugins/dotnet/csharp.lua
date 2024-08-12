return {
  "iabdelkareem/csharp.nvim",
  dependencies = {
    "williamboman/mason.nvim", -- Required, automatically installs omnisharp
    "mfussenegger/nvim-dap",
    "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
  },
  config = function()
    require("mason").setup() -- Mason setup must run before csharp, only if you want to use omnisharp
    require("csharp").setup({
      roslyn = {
        enable = true,
        cmd_path = "/Users/marka/work/nvim/Microsoft.CodeAnalysis.LanguageServer.osx-arm64.4.12.0-2.24409.2/content/LanguageServer/osx-arm64",
      },
    })

    vim.keymap.set("n", "<leader>F5", function()
      require("csharp").debug_project()
    end, { desc = "Debug dotnet project" })
  end,
}
