local M = {}

---@class SessionConfig
M.options = {
  save_on_vim_leave = true,
  hooks = {
    pre = {
      save = function() end,
      delete = function() end,
      load = function() end,
    },
    post = {
      save = function() end,
      delete = function() end,
      load = function() end,
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
