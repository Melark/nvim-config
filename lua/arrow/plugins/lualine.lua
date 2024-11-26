return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    local git_utils = require("arrow.functions.git-utils")

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = "nordic",
      },
      sections = {
        lualine_b = { git_utils.get_git_worktree, "branch", "diff", "diagnostics" },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
          -- {
          --   require("noice").api.statusline.mode.get,
          --   cond = require("noice").api.statusline.mode.has,
          --   color = { fg = "#ff9e64" },
          -- },
        },
      },
    })
  end,
}
