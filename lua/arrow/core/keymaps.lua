vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
keymap.set('n', '<Up>', ':resize +2<CR>', { desc = "Resize window up" })
keymap.set('n', '<Down>', ':resize -2<CR>', { desc = "Resize window down" })
keymap.set('n', '<Left>', ':vertical resize +2<CR>', { desc = "Resize window left" })
keymap.set('n', '<Right>', ':vertical resize -2<CR>', { desc = "Resize window right" })

-- Navigate between splits
keymap.set('n', '<C-k>', ':wincmd k<CR>', { desc = "Navigate split up" })
keymap.set('n', '<C-j>', ':wincmd j<CR>', { desc = "Navigate split down" })
keymap.set('n', '<C-h>', ':wincmd h<CR>', { desc = "Navigate split left" })
keymap.set('n', '<C-l>', ':wincmd l<CR>', { desc = "Navigate split right" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- buffers
keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Go to next buffer" }) 
keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Go to previous buffer" }) 
keymap.set("n", "<leader>bx", ":bdelete<CR>", { desc = "Delete buffer" }) 
keymap.set("n", "<leader>bn", "<cmd> enew <CR>", { desc = "New buffer" }) 

-- Toggle line wrapping
keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', { desc = "Toggle line wrap" })

-- notes
keymap.set("n", "<leader>on", ":ObsidianNew<cr>", { desc = "New note" })
keymap.set("n", "<leader>ot", ":ObsidianToday<cr>", { desc = "Open today's note" })
keymap.set("n", "<leader>oy", ":ObsidianYesterday<cr>", { desc = "Open yesterday's note" })

-- other from theprimeagen
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down one line" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up one line" })

keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Navigate half page and keep cursor in middle of the screen" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Navigate half page and keep cursor in middle of the screen" })


keymap.set("n", "n", "nzzzv", { desc = "Find and center" })
keymap.set("n", "N", "Nzzzv", { desc = "Find and center" })

keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor" }
)
