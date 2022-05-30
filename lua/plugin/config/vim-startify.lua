local startify = setmetatable({}, {
  __newindex = function(_, k, v)
    vim.g["startify_" .. k] = v
  end,
})

startify.bookmarks = {
  { c = vim.fn.stdpath("config") .. "/init.lua" },
}
