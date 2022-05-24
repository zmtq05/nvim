return require("lua-dev").setup {
  lspconfig = require("lsp.config") {
    settings = {
      Lua = {
        format = {
          enable = false, -- use stylua
        },
      },
    },
  },
}
