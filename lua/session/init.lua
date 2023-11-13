local M = {}

---@param opts? SessionConfig
function M.setup(opts)
  local config = require("session.config")
  config.set(opts)
end

return M
