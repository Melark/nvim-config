return {
  dir = "~/work/personal/git/docker-nvim", -- Your path
  name = "docker-nvim",
  config = function()
    vim.keymap.set("n", "<leader>dc", function()
      require("docker-nvim").show_containers()
    end, { desc = "Format file or range (in visual mode)" })

    -- vim.api.nvim_set_keymap(
    --   "n",
    --   "<leader>dc",
    --   '<cmd>lua require("docker_plugin").show_containers()<CR>',
    --   { noremap = true, silent = true }
    -- )
    -- vim.api.nvim_set_keymap(
    --   "n",
    --   "<leader>di",
    --   '<cmd>lua require("docker_plugin").show_images()<CR>',
    --   { noremap = true, silent = true }
    -- )
    -- vim.api.nvim_set_keymap(
    --   "n",
    --   "<leader>dv",
    --   '<cmd>lua require("docker_plugin").show_volumes()<CR>',
    --   { noremap = true, silent = true }
    -- )
  end,
}
