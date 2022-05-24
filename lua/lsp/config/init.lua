local default = {
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/documentHighlight") then
      nvim.aug("LspDocumentHighlight") {
        { "CursorHold", callback = vim.lsp.buf.document_highlight, buffer = bufnr },
        { { "CursorMoved", "InsertEnter" }, callback = vim.lsp.buf.clear_references, buffer = bufnr },
      }
    end

    local function set(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    local function n(...)
      return set("n", ...)
    end

    local function lua(cmd)
      return "<Cmd>lua " .. cmd .. "<CR>"
    end

    n("K", lua("vim.lsp.buf.hover()"))
    n("<leader>r", lua("vim.lsp.buf.rename()"))
    n("<leader>a", lua("vim.lsp.buf.code_action()"))
    n("<leader>f", lua("vim.lsp.buf.format()"))
    n("<leader>D", lua("vim.lsp.buf.type_definition()"))
    n("gr", lua("vim.lsp.buf.references()"))
    n("gd", lua("vim.lsp.buf.definition()"))
    n("gi", lua("vim.lsp.buf.implementation()"))

    n("]d", lua("vim.diagnostic.goto_next()"))
    n("[d", lua("vim.diagnostic.goto_prev()"))
    local err = "{ severity = vim.diagnostic.severity.ERROR }"
    n("]e", lua("vim.diagnostic.goto_next" .. err))
    n("[e", lua("vim.diagnostic.goto_prev" .. err))
  end,
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

local function combine(lhs, ...)
  local configs = { ... }

  local function invoke_if_exists(f, ...)
    if f then
      return f(...)
    end
  end

  local function new_on_attach(...)
    invoke_if_exists(lhs.on_attach, ...)
    for _, config in ipairs(configs) do
      invoke_if_exists(config.on_attach, ...)
    end
  end

  local new_config = vim.tbl_deep_extend("force", lhs, ...)
  new_config.on_attach = new_on_attach
  return new_config
end

return setmetatable({}, {
  __index = function(_, server_name)
    if server_name == "default" then
      return default
    end

    local ok, config = pcall(require, "lsp.config." .. server_name)
    if not ok then
      return default
    else
      return config
    end
  end,
  __call = function(_, ...)
    if vim.tbl_isempty(...) then
      return default
    end
    return combine(default, ...)
  end,
})
