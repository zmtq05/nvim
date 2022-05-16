-- onedarkpro
vim.api.nvim_set_hl(0, "DressingFloatBorder", { fg = "#3E4452", bg = "#21252B" })

vim.api.nvim_set_hl(0, "FloatTitle", { link = "NormalFloat" })
require("dressing").setup {
  input = {
    insert_only = true,
    border = "single",
    winhighlight = "FloatBorder:DressingFloatBorder",
  },
}
