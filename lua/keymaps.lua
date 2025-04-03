-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode

-- Toggle Terminal
vim.keymap.set({ 'n', 't' }, '<leader>tt', ':FloatTerminal<CR>')

-- Toggle FileTree
vim.keymap.set('n', '<leader>ft', ':NvimTreeToggle<CR>', { desc = 'Toggle File Tree' })

-------------
-- COPILOT --
-------------
-- Accept Copilot suggestion in insert mode with <leader>n
vim.keymap.set('i', '<leader>n', 'copilot#Accept("<CR>")', {
  expr = true,
  silent = true,
  noremap = true,
  desc = 'Accept Copilot Suggestion',
})

-- Accept Copilot suggestion in normal mode with <leader>n
vim.keymap.set('n', '<leader>n', function()
  if vim.fn['copilot#Visible']() == 1 then
    vim.fn.feedkeys(vim.fn['copilot#Accept'] '<CR>', '')
  end
end, { noremap = true, silent = true, desc = 'Accept Copilot Suggestion' })

-- Toggle Copilot on/off with <leader>cc
vim.keymap.set('n', '<leader>cc', function()
  local enabled = vim.g.copilot_enabled == 1
  if enabled then
    vim.cmd 'Copilot disable'
    vim.notify('🚫 Copilot disabled', vim.log.levels.WARN)
  else
    vim.cmd 'Copilot enable'
    vim.notify('✅ Copilot enabled', vim.log.levels.INFO)
  end
end, { noremap = true, silent = true, desc = 'Toggle Copilot' })

------------

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
