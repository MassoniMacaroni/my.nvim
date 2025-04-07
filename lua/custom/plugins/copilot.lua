return {
  {
    'github/copilot.vim',
    config = function()
      -- General settings
      vim.g.copilot_enabled = 0
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ''
    end,
  },
}
