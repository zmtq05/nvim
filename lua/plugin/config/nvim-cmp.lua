local set = vim.keymap.set
local cmp = require("cmp")
local ls = require("luasnip")

local function locally_jumpable(dir)
  return ls.in_snippet() and ls.jumpable(dir)
end

require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config {
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = false,
  ext_opts = {
    [require("luasnip.util.types").choiceNode] = {
      active = {
        virt_text = { { "●", "Cursor" } },
      },
    },
  },
}

set({ "i", "s" }, "<M-p>", function()
  if ls.expand_or_jumpable() then
    ls.expand()
  end
end)
set({ "i", "s" }, "<M-j>", function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end)
set({ "i", "s" }, "<M-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end)
set({ "i", "s" }, "<M-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
set({ "i", "s" }, "<M-h>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)

cmp.setup {
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "luasnip" },
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
  }),
  formatting = {
    format = require("lspkind").cmp_format {
      mode = "symbol_text",
      maxwidth = 50,
      menu = {
        buffer = "|BUF|",
        nvim_lsp = "|LSP|",
        luasnip = "|SNIP|",
      },
    },
  },
  mapping = {
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-l>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if locally_jumpable(1) then
        ls.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if locally_jumpable(-1) then
        ls.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-Space>"] = cmp.mapping.complete(),

    ["<CR>"] = cmp.mapping.confirm { select = false },

    ["<C-d>"] = cmp.mapping.scroll_docs(2),
    ["<C-u>"] = cmp.mapping.scroll_docs(-2),
  },
}

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = "buffer" },
  }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
