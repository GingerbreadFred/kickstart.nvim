return {
  {
    'AckslD/nvim-neoclip.lua',
    opts = {},
    -- Optional dependencies
    dependencies = { { 'nvim-telescope/telescope.nvim' } },
    config = function()
      require('neoclip').setup()
      vim.keymap.set({ 'n', 'i' }, '<leader>p', require('telescope').extensions.neoclip.default, { desc = '[P]aste History' })
    end,
  },
}
