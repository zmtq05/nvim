local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-q>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        q = actions.close,
        ["<C-d>"] = actions.results_scrolling_down,
        ["<C-u>"] = actions.results_scrolling_up,
      },
    },
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
    },
  },
}

local function t(cmd)
  return "<CMD>Telescope " .. cmd .. "<CR>"
end
vim.keymap.set("n", "?", t("help_tags"))
vim.keymap.set("n", "<leader>/", t("find_files"))
vim.keymap.set("n", "<leader>tg", t("live_grep"))
vim.keymap.set("n", "<leader>th", t("highlights"))

telescope.load_extension("fzf")
