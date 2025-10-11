return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim", -- cspell:disable-line
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      local ensure_installed = {}
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
        "eslint_d",
        "prettier",
        "cspell",
        "codespell",
        "gopls",
        "delve",
        "roslyn",
        "csharpier",
      })
      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
        auto_update = true,
      })
    end,
  },
}
