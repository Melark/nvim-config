return {
  "seblyng/roslyn.nvim",
  ft = "cs",
  config = function()
    require("roslyn").setup({
      config = {},
      broad_search = true,
    })
    -- create commands
    require("arrow.custom.roslyn_utils").setup()
  end,
}
