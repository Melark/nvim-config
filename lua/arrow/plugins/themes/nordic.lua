return {
  "AlexvZyl/nordic.nvim",
  lazy = false,
  enabled = false,
  priority = 1000,
  config = function()
    require("nordic").load({
      transparent = {
        -- Enable transparent background.
        bg = true,
        -- Enable transparent background for floating windows.
        float = false,
      },
    })
  end,
}
