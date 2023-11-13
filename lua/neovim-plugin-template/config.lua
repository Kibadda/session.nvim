local M = {}

---@class NeovimPluginTemplateConfig
M.options = {}

---@param opts? NeovimPluginTemplateConfig
function M.set(opts)
  M.options = vim.tbl_deep_extend("force", opts or {})
end

return M
