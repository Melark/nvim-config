return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  config = function()
    require("mini.ai").setup()

    require("mini.surround").setup()
    require("mini.operators").setup()
    require("mini.pairs").setup()
    require("mini.bracketed").setup()
    require("mini.files").setup()
    require("mini.indentscope").setup({
      symbol = "┊",
      draw = {
        animation = require("mini.indentscope").gen_animation.none(),
      },
    })
  end,
}
