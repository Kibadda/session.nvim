---@class session.config
---@field dir? string path to session directory
---@field save_on_exit? boolean wether session should be saved on VimLeave

---@class session.internalconfig
local SessionDefaultConfig = {
  dir = vim.fn.stdpath "data" .. "/session",
  save_on_exit = true,
}

---@type session.config | (fun(): session.config) | nil
vim.g.session = vim.g.session

---@type session.config
local opts = type(vim.g.session) == "function" and vim.g.session() or vim.g.session or {}

---@type session.internalconfig
local SessionConfig = vim.tbl_deep_extend("force", {}, SessionDefaultConfig, opts)

local ok = require("session.config.check").validate(SessionConfig)
if not ok then
  vim.notify("session: there are errors in your config. see `:checkhealth session`", vim.log.levels.ERROR)
end

return SessionConfig
