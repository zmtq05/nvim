local option = {
  number = true,
  relativenumber = true,
  clipboard = "unnamedplus",
  mouse = "a",
  softtabstop = 2,
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  splitbelow = true,
  splitright = true,
  ignorecase = true,
  smartcase = true,
  wrap = false,
  scrolloff = 2,
  sidescrolloff = 5,
  pumheight = 7,
  termguicolors = true,
  hlsearch = false,
}

for k, v in pairs(option) do
  vim.o[k] = v
end
