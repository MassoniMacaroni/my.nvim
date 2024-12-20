-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

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

vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')

-- Firenvim opts
-- Add support for more filetypes
vim.filetype.add {
  extension = {
    spl = 'spl',
    spl2 = 'spl2',
  },
}

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*splunkcloud.com_*.txt',
  command = 'set filetype=spl',
})

vim.g.firenvim_config = {
  globalSettings = { alt = 'all' },
  localSettings = {
    ['.*'] = {
      cmdline = 'neovim',
      content = 'text',
      priority = 0,
      selector = 'textarea',
      takeover = 'never',
      filename = '/tmp/{hostname}_{pathname%5}.{extension}',
    },
  },
}

vim.api.nvim_create_autocmd({ 'UIEnter' }, {
  callback = function(event)
    local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
    if client ~= nil and client.name == 'Firenvim' then
      vim.o.laststatus = 0
      vim.opt.guifont = 'Cousine Nerd Font:h11'
    end
  end,
})

if vim.g.started_by_firenvim then
  vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
    nested = true,
    command = 'silent write',
  })
end

-- End firenvim opts

-- Nvim-Tree opts
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.keymap.set('n', '<leader>ft', ':NvimTreeToggle<CR>')
-- vim: ts=2 sts=2 sw=2 et
