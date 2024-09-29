return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    -- This function opens a new perminent buffer on the right
    -- this buffer contains the harpoon list of files and indexes
    local function open_harpoon(harpoon_files)
      local file_paths = {}
      for index, item in ipairs(harpoon_files.items) do
        if index == 1 then
          table.insert(file_paths, string.format("h %d: %s", index, item.value))
        end
        if index == 2 then
          table.insert(file_paths, string.format("t %d: %s", index, item.value))
        end
        if index == 3 then
          table.insert(file_paths, string.format("n %d: %s", index, item.value))
        end
        if index == 4 then
          table.insert(file_paths, string.format("s %d: %s", index, item.value))
        end
      end

      -- This is the buffer that will hold the harpoon list
      local buf = vim.api.nvim_create_buf(false, true)

      -- This is the window that will hold the harpoon list
      local win = vim.api.nvim_open_win(buf, true, {
        relative = "win",
        width = 40,
        height = 4,
        row = 1,
        col = vim.api.nvim_win_get_width(0) - 41,
        style = "minimal",
        border = "single",
      })

      -- This is the window that will hold the harpoon list
      vim.api.nvim_win_set_option(win, "buftype", "nofile")
      vim.api.nvim_win_set_option(win, "bufhidden", "wipe")
      vim.api.nvim_win_set_option(win, "swapfile", false)
      vim.api.nvim_win_set_option(win, "buflisted", false)
      vim.api.nvim_win_set_option(win, "filetype", "harpoon")

      -- write the file paths to the buffer
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, file_paths)
    end

    vim.keymap.set("n", "<leader>h", function()
      open_harpoon(harpoon:list())
    end)

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
    vim.keymap.set("n", "<leader><C-h>", function() harpoon:list():replace_at(1) end)
    vim.keymap.set("n", "<leader><C-t>", function() harpoon:list():replace_at(2) end)
    vim.keymap.set("n", "<leader><C-n>", function() harpoon:list():replace_at(3) end)
    vim.keymap.set("n", "<leader><C-s>", function() harpoon:list():replace_at(4) end)
  end
}
