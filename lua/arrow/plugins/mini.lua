return {
  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup({ n_lines = 500 })

      require("mini.surround").setup()
      require("mini.statusline").setup()
    end,
  },
}
