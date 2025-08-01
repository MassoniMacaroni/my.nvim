return {
  {
    'github/copilot.vim',
    config = function()
      -- General settings
      vim.g.copilot_enabled = 0
      vim.g.copilot_no_tab_map = true
      -- Set to true to assume that copilot is already mapped
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ''

      -- Set workspace folders
      vim.g.copilot_workspace_folders = '~/workspace'

      vim.g.copilot_filetypes = {
        ['TelescopePrompt'] = false,
      }

      -- Setup keymaps
      local keymap = vim.keymap.set
      local opts = { silent = true }

      keymap('n', '<leader>cc', function()
        local enabled = vim.g.copilot_enabled == 1
        if enabled then
          vim.g.copilot_enabled = 0
          vim.notify('🚫 Copilot disabled', vim.log.levels.WARN)
        else
          vim.g.copilot_enabled = 1
          vim.notify('✅ Copilot enabled', vim.log.levels.INFO)
        end
      end, { noremap = true, silent = true, desc = 'Toggle Copilot' })

      -- Set <C-y> to accept copilot suggestion
      keymap('i', '<C-y>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, desc = 'Accept copilot suggestions' })

      -- Set <C-i> to accept line
      keymap('i', '<C-i>', '<Plug>(copilot-accept-line)', opts)

      -- Set <C-j> to next suggestion, <C-k> to previous suggestion, <C-l> to suggest
      keymap('i', '<C-j>', '<Plug>(copilot-next)', opts)
      keymap('i', '<C-k>', '<Plug>(copilot-previous)', opts)
      keymap('i', '<C-l>', '<Plug>(copilot-suggest)', opts)

      -- Set <C-d> to dismiss suggestion
      keymap('i', '<C-d>', '<Plug>(copilot-dismiss)', opts)
    end,
  },
}
