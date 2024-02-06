local M = {}

---@class SessionConfig
M.options = {
  save_on_vim_leave = true,
  hooks = {
    ---@type table<"save"|"delete"|"load", function?>
    pre = {
      save = nil,
      delete = nil,
      load = nil,
    },
    ---@type table<"save"|"delete"|"load", function?>
    post = {
      save = nil,
      delete = nil,
      load = nil,
    },
  },
  dir = vim.fn.stdpath "data" .. "/session",
}

--- update options
---
---@param opts? SessionConfig
function M.set(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M
