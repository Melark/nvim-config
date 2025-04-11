return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.pairs").setup() --Auto bracket pairs
    require("mini.ai").setup()
    require("mini.sessions").setup({
      -- Whether to read default session if Neovim opened without file arguments
      autoread = false,
      -- Whether to write currently read session before quitting Neovim
      autowrite = true,
      -- Whether to force possibly harmful actions (meaning depends on function)
      force = { read = false, write = true, delete = false },
      -- Hook functions for actions. Default `nil` means 'do nothing'.
      hooks = {
        -- Before successful action
        pre = { read = nil, write = nil, delete = nil },
        -- After successful action
        post = { read = nil, write = nil, delete = nil },
      },

      -- Whether to print session path after action
      verbose = { read = false, write = true, delete = true },
    })
    require("mini.comment").setup()
    require("mini.indentscope").setup({
      symbol = "┊",
      draw = {
        animation = require("mini.indentscope").gen_animation.none(),
      },
    })
    require("mini.statusline").setup()
  end,
}
