local autopairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")
local ts_cond = require("nvim-autopairs.ts-conds")

autopairs.setup {
  check_ts = true,
  map_c_w = true,
}

autopairs.add_rules {
  Rule(" ", " "):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({ "()", "[]", "{}" }, pair)
  end),
  Rule("( ", " )")
    :with_pair(cond.none())
    :with_move(function(opts)
      return opts.prev_char:match(".%)") ~= nil
    end)
    :use_key(")"),
  Rule("{ ", " }")
    :with_pair(cond.none())
    :with_move(function(opts)
      return opts.prev_char:match(".%}") ~= nil
    end)
    :use_key("}"),
  Rule("[ ", " ]")
    :with_pair(cond.none())
    :with_move(function(opts)
      return opts.prev_char:match(".%]") ~= nil
    end)
    :use_key("]"),
}

local rust_generic = Rule("<", ">", "rust")
  :with_pair(cond.before_regex("%a+"))
  :with_pair(cond.not_after_regex("%a"))
  :with_move(ts_cond.is_ts_node { "type_arguments", "type_parameters" })

autopairs.add_rule(rust_generic)

if pcall(require, "cmp") then
  local cmp = require("cmp")
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { rust = "" } })
end
