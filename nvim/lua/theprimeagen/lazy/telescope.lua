return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  -- dependencies = {
  --     "nvim-lua/plenary.nvim"
  -- },

  config = function()
    require('telescope').setup({})

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>pws', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>pWs', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>fg', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

    vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>')

    builtin.telescope.defaults.layout_strategy = "flex"
    builtin.telescope.defaults.layout_config = {
      height = 0.8,
      width = 0.8,
      horizontal = {
        preview_cutoff = 120,
        preview_width = 0.6,
      },
      vertical = {
        preview_cutoff = 40,
      },
      flex = {
        flip_columns = 150,
      },
    }
  end
}
