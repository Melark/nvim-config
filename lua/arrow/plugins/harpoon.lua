return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Add to harpoon list" })

    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Toggle harpoon quicklist" })

    vim.keymap.set("n", "<C-n>", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<C-m>", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<C-,>", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<C-.>", function()
      harpoon:list():select(4)
    end)

    vim.keymap.set("n", "<C-S-n>", function()
      harpoon:list():prev()
    end, { desc = "Go to previous harpoon item" })

    vim.keymap.set("n", "<C-S-m>", function()
      harpoon:list():next()
    end, { desc = "Go to next harpoon item" })
  end,
}
