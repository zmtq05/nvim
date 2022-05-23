local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local configured_servers = {
  "sumneko_lua",
}

require("nvim-lsp-installer").setup {
  ensure_installed = { "sumneko_lua" },
  ui = {
    keymaps = {
      toggle_server_expand = "o",
    },
  },
}

local lspconfig = require("lspconfig")
local configs = require("lsp.config")

for _, server in ipairs(configured_servers) do
  lspconfig[server].setup(configs[server])
end
