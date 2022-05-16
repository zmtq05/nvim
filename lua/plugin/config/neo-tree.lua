vim.g.neo_tree_remove_legacy_commands = 1

local neotree = require("neo-tree")

local auto_close = {
  event = "file_opened",
  handler = function()
    neotree.close_all()
  end,
}
local no_signcolumn = {
  event = "neo_tree_buffer_enter",
  handler = function()
    vim.api.nvim_win_set_option(0, "signcolumn", "no")
  end,
}

local option = {
  use_popups_for_input = true,
  window = {
    mappings = { o = "open" },
    width = 30,
  },
  event_handlers = {
    auto_close,
    no_signcolumn,
  },
}

if pcall(require, "dressing") then
  option.use_popups_for_input = false
end

neotree.setup(option)

vim.keymap.set("n", "<leader>e", "<cmd>Neotree<CR>")
