require("toggleterm").setup {
  open_mapping = "<C-s>",
  on_open = function(term)
    vim.api.nvim_win_set_option(term.window, "cursorline", false)
  end,
}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new {
  cmd = "lazygit",
  direction = "float",
  hidden = true,
}
vim.keymap.set("n", "<leader>m", function()
  lazygit:toggle()
end)
