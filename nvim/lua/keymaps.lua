local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- New tab
keymap("n", "te", ":tabedit", opts)
-- Make new tab on the very right
keymap("n", "gn", ":tabnew<Return>", opts)
-- move tab
keymap("n", "gh", "gT", opts)
keymap("n", "gl", "gt", opts)

-- Split window
vim.api.nvim_create_user_command(
  'VsplitOrWincmdw',
  function()
    local number_of_windows = #vim.api.nvim_list_wins()
    if number_of_windows == 1 then
      vim.cmd('vsplit')
      return
    else
      vim.cmd('wincmd w')
      return
    end
  end,
  { nargs = 0}
)
keymap("n", "ss", ":VsplitOrWincmdw<CR>", opts)

-- Open explorer(netrw)
-- keymap("n", "-", ":Ex<CR>", opts)
keymap("n", "-", ":NeoTreeShow<CR>", opts)

-- Do not yank with x
keymap("n", "x", '"_x', opts)

-- Delete a word backwards
keymap("n", "dw", 'vb"_d', opts)

-- Escape twice de-highlight for the searched word
keymap("n", "<Esc><Esc>", ":<C-u>set nohlsearch<Return>", opts)

-- Insert --
-- Press jj fast to exit insert mode
keymap("i", "jj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- 0番レジスタを使いやすくした
keymap("v", "<C-p>", '"0p', opts)
