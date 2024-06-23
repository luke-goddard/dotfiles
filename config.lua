-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- Configure telescope size
lvim.builtin.telescope.defaults.layout_strategy = "flex"
lvim.builtin.telescope.defaults.layout_config = {
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

for key, _ in pairs(lvim.builtin.telescope.pickers) do
  lvim.builtin.telescope.pickers[key].previewer = nil
  lvim.builtin.telescope.pickers[key].theme = nil
end


-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*",
  timeout = 1000,
}
lvim.builtin.bufferline.active = false
lvim.keys.insert_mode["<tab>"] = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = ","
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["d"] = {
  {
    name = "Documentation",
    d = { "<cmd>DogeGenerate<cr>", "Gen Docs" },
  },
}

lvim.builtin.which_key.mappings["f"] = {
  {
    name = "Telescope",
    f = { "<cmd>Telescope git_files<cr>", "Files" },
    g = { "<cmd>Telescope live_grep<cr>", "Grep" },
    t = { "<cmd>Telescope <cr>", "Telescope" },
    p = { "<cmd>Telescope projects<cr>", "Projects" },
    r = { "<cmd>Telescope lsp_references<cr>", "References" },
    s = { "<cmd>Telescope git_status<cr>", "Git Status" },
  },
}

lvim.builtin.which_key.mappings["t"] = {
  {
    name = "Trouble",
    n = { ":lua require('trouble').next({skip_groups = true, jump = true}) <cr>", "Next" },
    p = { ":lua require('trouble').previous({skip_groups = true, jump = true}) <cr>;", "Previous" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document" },
    t = { "<cmd>TroubleToggle<cr>", "Toggle" },
  },
}

lvim.builtin.which_key.mappings["h"] = {
  name = "Harpoon",
  m = { ':lua require("harpoon.mark").add_file()<cr>', "Mark file" },
  a = { ':lua require("harpoon.mark").add_file()<cr>', "Mark file" },
  l = { ':lua require("harpoon.ui").toggle_quick_menu()<cr>', "List" },
  n = { ':lua require("harpoon.ui").nav_next()<cr>', "Next" },
  p = { ':lua require("harpoon.ui").nav_prev()<cr>', "Previous" },
}

-- -- Change theme settings
-- lvim.colorscheme = "lunar"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "stylua" },
  {
    command = "prettierd",
    filetypes = { "typescript", "typescriptreact" },
  },
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
})

local manager = require("lvim.lsp.manager")

manager.setup("tailwindcss-language-server", {
  filetypes = { "html", "vue", "typescriptreact", "javascriptreact" }
})

manager.setup("rust-analyzer", {
  filetypes = { "rust" }
})


local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    command = "proselint",
    args = { "--json" },
    filetypes = { "markdown", "tex" },
  },
}

lvim.builtin.sell_soul_to_devel = true

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  {
    "kkoomen/vim-doge",
    config = function()
      vim.cmd(":call doge#install()")
    end,
  },
  { "folke/trouble.nvim" },
  { "ThePrimeagen/harpoon" },
  -- { "github/copilot.vim" },
  {"zbirenbaum/copilot-cmp"},
  { "zbirenbaum/copilot.lua" },
}

require("copilot").setup() -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration

table.insert(lvim.plugins, {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot.lua" },
  config = function()
    vim.defer_fn(function()
      require("copilot").setup() -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
      require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
    end, 100)
  end,
})

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
local cmp = require("cmp")
lvim.builtin.cmp.mapping["<C-e>"] = function(fallback)
  cmp.mapping.abort()
  local copilot_keys = vim.fn["copilot#Accept"]()
  if copilot_keys ~= "" then
    vim.api.nvim_feedkeys(copilot_keys, "i", true)
  else
    fallback()
  end
end

vim.api.nvim_set_keymap("i", "<C-e>", "copilot#Accept('<CR>')", { expr = true, noremap = true })
-- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})
