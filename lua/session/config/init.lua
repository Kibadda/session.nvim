---@class session.Config
---@field dir? string path to session directory
---@field save_on_exit? boolean wether session should be saved on VimLeave

---@class session.InternalConfig
local SessionDefaultConfig = {
  dir = vim.fn.stdpath "data" .. "/session",
  save_on_exit = true,
}

---@type session.Config | (fun(): session.Config) | nil
vim.g.session = vim.g.session

---@type session.Config
local opts = type(vim.g.session) == "function" and vim.g.session() or vim.g.session or {}

---@type session.Config
local SessionConfig = vim.tbl_deep_extend("force", {}, SessionDefaultConfig, opts)

local check = require "session.config.check"
local ok, err = check.validate(SessionConfig)
if not ok then
  vim.notify("session: " .. err, vim.log.levels.ERROR)
end

return SessionConfig
