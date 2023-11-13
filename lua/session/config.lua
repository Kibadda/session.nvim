local M = {}

---@class SessionConfig
M.options = {}

---@param opts? SessionConfig
function M.set(opts)
  M.options = vim.tbl_deep_extend("force", opts or {})
end

return M
