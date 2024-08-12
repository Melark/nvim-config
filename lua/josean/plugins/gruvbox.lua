return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("quick-settings")
    vim.cmd.colorscheme("gruvbox")

    if vim.g.gs_theme == "light" then
      vim.o.background = "light"
    else
      vim.o.background = "dark"
      vim.cmd.colorscheme("gruvbox")
    end
  end,
}
