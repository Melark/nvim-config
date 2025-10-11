return {

  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   build = "cd app && npm install",
  --   init = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --   end,
  --   ft = { "markdown" },
  -- },
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      -- refer to `:h file-pattern` for more examples
      "BufReadPre C:/notes/*.md",
      "BufNewFile C:/notes/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "notes",
          path = "C:/notes",
        },
      },
      notes_subdir = "inbox",
      new_notes_location = "notes_subdir",
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "dailies",
      },
      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        -- Enables completion using nvim_cmp
        nvim_cmp = true,
        -- Enables completion using blink.cmp
        blink = false,
        -- Trigger completion at 2 chars.
        min_chars = 2,
        -- Set to false to disable new note creation in the picker
        create_new = true,
      },
      disable_frontmatter = false,
      -- Either 'wiki' or 'markdown'.
      preferred_link_style = "wiki",
      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'.
        -- You may have as many periods in the note ID as you'd like—the ".md" will be added automatically
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        note_mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-l>",
        },
        tag_mappings = {
          -- Add tag(s) to current note.
          tag_note = "<C-x>",
          -- Insert a tag at the current location.
          insert_tag = "<C-l>",
        },
      },
      ---@class obsidian.config.FooterOpts
      ---
      ---@field enabled? boolean
      ---@field format? string
      ---@field hl_group? string
      ---@field separator? string|false Set false to disable separator; set an empty string to insert a blank line separator.
      footer = {
        enabled = true,
        format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars",
        hl_group = "Comment",
        separator = string.rep("-", 80),
      },
      ---@class obsidian.config.CheckboxOpts
      ---
      ---Order of checkbox state chars, e.g. { " ", "x" }
      ---@field order? string[]
      checkbox = {
        order = { " ", "~", "x" },
      },
      callbacks = {
        enter_note = function(_, note)
          vim.keymap.set("n", "<Tab>", function()
            require("obsidian.api").nav_link("next")
          end, {
            buffer = note.bufnr,
            desc = "Go to next link",
          })
          vim.keymap.set("n", "<S-Tab>", function()
            require("obsidian.api").nav_link("prev")
          end, {
            buffer = note.bufnr,
            desc = "Go to previous link",
          })
        end,
      },
    },
  },
}
