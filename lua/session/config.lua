local M = {}

---@class SessionConfig
---@field dir string path to session directory
---@field save_on_exit boolean wether session should be saved on VimLeave

M.defaults = {
  dir = vim.fn.stdpath "data" .. "/session",
  save_on_exit = true,
}

---@return SessionConfig
function M.get()
  ---@type SessionConfig
  local config = vim.g.session or {}

  vim.validate("config", config, "table")

  vim.validate {
    dir = { config.dir, "string", true },
    save_on_exit = { config.save_on_exit, "boolean", true },
  }

  return vim.tbl_deep_extend("force", {}, M.defaults, config)
end

return M
