return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("git_worktree")

    -- set keymaps
    local builtin = require("telescope.builtin")
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>th", "<cmd>Telescope colorscheme<cr>", { desc = "Colorscheme picker with Telescope" })
    keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    keymap.set("n", "<leader>fa", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })

    keymap.set("n", "<leader>wf", function()
      require("telescope").extensions.git_worktree.git_worktrees()
    end, { desc = "Show git worktrees" })

    keymap.set("n", "<leader>wc", function()
      require("telescope").extensions.git_worktree.create_git_worktree()
    end, { desc = "Create a git worktree" })

    keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>fn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Seach NVIM config" })

    require("telescope").load_extension("fzf")
  end,
}
