return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.pairs").setup() --Auto bracket pairs
    require("mini.ai").setup()
    require("mini.comment").setup()
    require("mini.indentscope").setup()
  end,
}
