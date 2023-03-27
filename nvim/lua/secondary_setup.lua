local tele_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fT', tele_builtin.treesitter, {})
vim.keymap.set('n', '<leader>ft', tele_builtin.tagstack, {})
vim.keymap.set('n', '<leader>fr', tele_builtin.registers, {})
vim.keymap.set('n', '<leader>fh', tele_builtin.help_tags, {})
vim.keymap.set('n', '<leader>ff', tele_builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', tele_builtin.buffers, {})
vim.keymap.set('n', '<leader>fG', tele_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', function()
  tele_builtin.live_grep({grep_open_files=true})
end, {})

require('telescope').setup{
  pickers = {
    find_files = {
      follow=true,  -- follow symlinks
    },
    -- live_grep = { theme = 'ivy' },
    -- buffers = { theme = 'ivy' },
    -- help_tags = { theme = 'ivy' },
  },
}
