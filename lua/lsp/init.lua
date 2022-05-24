local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local configured_servers = require("plenary.scandir").scan_dir(vim.fn.stdpath("config") .. "/lua/lsp/config", {
  search_pattern = function(e)
    return not e:match("init.lua")
  end,
})
configured_servers = vim.tbl_map(function(e)
  return e:match("/([%a-_]*).lua$")
end, configured_servers)

require("nvim-lsp-installer").setup {
  automatic_installation = true,
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
