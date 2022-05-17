_G.nvim = {}

---@class AucmdTable
---@field [1] string #event
---@field group string
---@field callback string | fun()
---@field pattern string | string[]
---@field command string

---@param aucmd_table AucmdTable
function nvim.autocmd(aucmd_table)
  local event = aucmd_table[1]
  aucmd_table[1] = nil
  return vim.api.nvim_create_autocmd(event, aucmd_table)
end

---@param group_name string
---@return fun(t: AucmdTable | AucmdTable[])
function nvim.augroup(group_name)
  local group = vim.api.nvim_create_augroup(group_name, { clear = true })

  ---@param t AucmdTable
  local function create_autocmd(t)
    t.group = group
    nvim.autocmd(t)
  end

  ---@param aucmd_tables AucmdTable | AucmdTable[]
  return function(aucmd_tables)
    if type(aucmd_tables[1]) ~= "table" or vim.tbl_islist(aucmd_tables[1]) then
      create_autocmd(aucmd_tables)
      return
    end

    for _, aucmd in ipairs(aucmd_tables) do
      create_autocmd(aucmd)
    end
  end
end

nvim.aug = nvim.augroup
nvim.au = nvim.autocmd

---@param cmd string command name
---@param ... any[] arguments
function nvim.cmd(cmd, ...)
  vim.api.nvim_cmd({
    cmd = cmd,
    args = { ... },
  }, {})
end
