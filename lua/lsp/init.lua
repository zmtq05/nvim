local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

require("nvim-lsp-installer").setup {
  ensure_installed = { "sumneko_lua" },
  automatic_installation = true,
  ui = {
    keymaps = {
      toggle_server_expand = "o",
    },
  },
}

local lsp = require("lspconfig")

lsp.sumneko_lua.setup {
  capabilities = capabilities,
  root_dir = function(fname)
    return lsp.util.find_git_ancestor(fname) or vim.loop.cwd()
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}
